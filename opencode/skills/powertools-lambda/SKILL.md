---
name: powertools-lambda
description: Use AWS Lambda Powertools for TypeScript when implementing or reviewing Lambda observability, structured logging, metrics, tracing, event parsing, validation, idempotency, batch processing, or related serverless utilities.
---

# Powertools for AWS Lambda

Use [Powertools for AWS Lambda (TypeScript)](https://docs.aws.amazon.com/powertools/typescript/latest/llms.txt) to apply serverless operational practices without building them from scratch. Prefer the smallest set of utilities that solves the problem, and follow the conventions already used by the application.

## First Steps

1. Read the function's `package.json`, deployment configuration, and existing handler pattern.
2. Check the installed Powertools major version and consult the matching [upgrade guide](https://docs.aws.amazon.com/powertools/typescript/latest/upgrade/index.md) before copying an example.
3. Install only the packages needed:

```sh
pnpm add @aws-lambda-powertools/logger
pnpm add @aws-lambda-powertools/metrics
pnpm add @aws-lambda-powertools/tracer
```

Add `@aws-lambda-powertools/parser`, `@aws-lambda-powertools/validation`, `@aws-lambda-powertools/idempotency`, `@aws-lambda-powertools/batch`, `@aws-lambda-powertools/parameters`, or `@aws-lambda-powertools/commons` only when required. Add `@middy/core` when using middleware and `zod` when using the parser's built-in schemas or a Zod schema.

## Core Rules

- Instantiate `Logger`, `Metrics`, `Tracer`, persistence layers, and reusable AWS SDK clients outside the handler. Lambda execution environments are reused, which reduces initialization work and allows Powertools to track cold starts.
- Keep invocation-specific state inside the handler or clean it up in a `finally` block. In particular, clear temporary Logger keys and do not leave request data on global objects.
- Use one consistent `serviceName` across Logger, Metrics, and Tracer. Set it explicitly or through `POWERTOOLS_SERVICE_NAME`.
- Do not log secrets, authorization headers, tokens, payment data, or complete events by default. Event logging is disabled by default for a reason; enable it only in controlled environments and redact sensitive fields.
- Re-throw failures after logging or tracing them unless the function's contract explicitly handles the error. Do not turn failed invocations into successful Lambda responses accidentally.
- Use CloudWatch metric dimensions sparingly. A high-cardinality value such as a request ID, user ID, or transaction ID belongs in log metadata, not a metric dimension.
- Prefer Middy middleware or the functional API for new code. Use decorators only when the project already uses experimental TypeScript decorators and accepts their async behavior.

## Recommended Handler Composition

Middy is a good default when a function needs several cross-cutting concerns:

```ts
import { Logger } from '@aws-lambda-powertools/logger';
import { injectLambdaContext } from '@aws-lambda-powertools/logger/middleware';
import { Metrics, MetricUnit } from '@aws-lambda-powertools/metrics';
import { logMetrics } from '@aws-lambda-powertools/metrics/middleware';
import { Tracer } from '@aws-lambda-powertools/tracer';
import { captureLambdaHandler } from '@aws-lambda-powertools/tracer/middleware';
import middy from '@middy/core';

const logger = new Logger({ serviceName: 'orders' });
const metrics = new Metrics({ namespace: 'TradingApplication', serviceName: 'orders' });
const tracer = new Tracer({ serviceName: 'orders' });

const lambdaHandler = async (event: OrderEvent): Promise<void> => {
  logger.info('Processing order', { orderId: event.orderId });
  metrics.addMetric('OrdersProcessed', MetricUnit.Count, 1);
};

export const handler = middy(lambdaHandler)
  .use(captureLambdaHandler(tracer))
  .use(injectLambdaContext(logger, { resetKeys: true }))
  .use(logMetrics(metrics));
```

For a plain functional handler, call `logger.addContext(context)`, optionally call `logger.logEventIfEnabled(event)`, instrument a Tracer subsegment only when needed, and always call `metrics.publishStoredMetrics()` after adding metrics. Middleware or decorators handle these lifecycle details automatically.

## Logger

- Use structured fields rather than interpolating large objects into message strings: `logger.info('Order processed', { orderId })`.
- Use `injectLambdaContext(logger)` or `logger.addContext(context)` to include `cold_start`, function identity, and request ID fields.
- Use `setCorrelationId()` or the built-in correlation ID search function for request/event IDs that must connect logs across services.
- Use `appendKeys()` only for short-lived context and pair it with `resetKeys()` or `removeKeys()` in `finally`.
- Pass caught errors as structured error data: `logger.error('Order failed', { error })`.
- Treat `logEvent` and `POWERTOOLS_LOGGER_LOG_EVENT=true` as sensitive-data switches, not normal production defaults.
- Use `POWERTOOLS_LOG_LEVEL`, `POWERTOOLS_SERVICE_NAME`, and `POWERTOOLS_LOGGER_SAMPLE_RATE` for deploy-time configuration. AWS Lambda Advanced Logging Controls can discard messages below its configured level.

## Metrics

- Configure a meaningful namespace and service dimension.
- Add metrics during invocation, not in module scope, unless the metric is intentionally cold-start-only.
- Use `MetricUnit` and `MetricResolution` rather than unvalidated strings or numbers where possible.
- Flush exactly once per invocation with `publishStoredMetrics()`, or use `logMetrics(metrics)` / `@metrics.logMetrics()`.
- Use `throwOnEmptyMetrics` only when the handler contract requires every invocation to emit a metric.
- Remember that EMF metrics are emitted to logs and extracted asynchronously by CloudWatch; they are not a synchronous metrics API.

## Tracing

- Enable AWS Lambda Active Tracing and the required execution-role permissions before expecting X-Ray traces.
- Use `captureLambdaHandler(tracer)` for handler lifecycle, error, response, cold-start, and service annotations.
- Use `tracer.captureAWSv3Client(client)` for AWS SDK v3 clients created outside the handler.
- Use annotations for low-cardinality values used to filter traces; use metadata for richer or high-cardinality context.
- Disable response or error capture when values may contain sensitive data, are too large, or are stream-like and can only be read once.
- With ESM and esbuild, account for Tracer's CommonJS dependency. Follow the deployment tool's documented `createRequire` banner pattern rather than guessing at bundler settings.

## Parsing and Validation

Use `@aws-lambda-powertools/parser` for TypeScript-first Standard Schema parsing and its built-in AWS event schemas/envelopes:

```ts
import { parser } from '@aws-lambda-powertools/parser/middleware';
import { EventBridgeEnvelope } from '@aws-lambda-powertools/parser/envelopes/eventbridge';
import middy from '@middy/core';
import { z } from 'zod';

const orderSchema = z.object({
  orderId: z.string().min(1),
});

export const handler = middy()
  .use(parser({ schema: orderSchema, envelope: EventBridgeEnvelope }))
  .handler(async (event) => {
    // event is the parsed order detail
    return { orderId: event.orderId };
  });
```

- Extend a built-in event schema when handler logic needs both AWS envelope metadata and custom fields.
- Use an envelope when only the inner payload matters.
- Use `safeParse: true` when invalid input is an expected, explicitly handled outcome; otherwise allow parsing to fail the invocation.
- Use `z.infer<typeof schema>` or the equivalent Standard Schema type instead of duplicating event types.
- Prefer `Validation` when the system already owns JSON Schema/Ajv definitions or needs its JSON Schema-oriented behavior.

## Idempotency

Use `@aws-lambda-powertools/idempotency` around operations with retryable external side effects, such as charging a payment or creating a subscription.

- Choose a stable idempotency key or `eventKeyJmesPath`; exclude timestamps, transport metadata, and other fields that change between retries.
- Return a JSON-serializable result. DynamoDB persistence has a 400 KB item limit for stored responses.
- Provision the persistence layer and IAM permissions deliberately. DynamoDB needs `GetItem`, `PutItem`, `UpdateItem`, and `DeleteItem`.
- Register Lambda context with `IdempotencyConfig` when wrapping an inner function so timeout-aware in-progress expiry works.
- Understand exception behavior: an exception inside the idempotent function generally removes its record and permits a retry; persistence-layer failures are separate failures.
- Use the function wrapper when the handler may return `undefined` or when only one operation should be idempotent; Middy middleware has an early-return limitation and requires a non-`undefined` result.

## Other Utilities

Consult the official documentation before implementing these features:

- [Batch processing](https://docs.aws.amazon.com/powertools/typescript/latest/features/batch/index.md) for SQS, Kinesis, and DynamoDB Streams partial failures.
- [Parameters](https://docs.aws.amazon.com/powertools/typescript/latest/features/parameters/index.md) for cached configuration and secrets retrieval.
- [HTTP API event handler](https://docs.aws.amazon.com/powertools/typescript/latest/features/event-handler/http/index.md) for routing and typed HTTP responses.
- [JMESPath functions](https://docs.aws.amazon.com/powertools/typescript/latest/features/jmespath/index.md) for extracting event data and idempotency keys.
- [Environment variables](https://docs.aws.amazon.com/powertools/typescript/latest/environment-variables/index.md) for deploy-time configuration.

## Testing Checklist

- Mock or isolate console output for Logger and EMF metrics; reset environment variables between tests.
- Test cold-start behavior only when it is part of the contract; module-level singletons make test isolation important.
- Test invalid parser input, envelope extraction, and safe-parse branches.
- Test repeated idempotent calls return the stored result and do not repeat side effects.
- Test batch handlers return the correct partial batch failure shape for the event source.
- Run the repository's targeted typecheck, lint, and test commands after changes.

## Authoritative References

- [Powertools TypeScript documentation index](https://docs.aws.amazon.com/powertools/typescript/latest/llms.txt)
- [Getting started and usage patterns](https://docs.aws.amazon.com/powertools/typescript/latest/getting-started/usage-patterns/index.md)
- [Logger](https://docs.aws.amazon.com/powertools/typescript/latest/features/logger/index.md)
- [Metrics](https://docs.aws.amazon.com/powertools/typescript/latest/features/metrics/index.md)
- [Tracer](https://docs.aws.amazon.com/powertools/typescript/latest/features/tracer/index.md)
- [Parser](https://docs.aws.amazon.com/powertools/typescript/latest/features/parser/index.md)
- [Idempotency](https://docs.aws.amazon.com/powertools/typescript/latest/features/idempotency/index.md)
