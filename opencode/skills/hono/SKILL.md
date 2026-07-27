---
name: hono
description: Use when working with Hono, hono apps, Hono middleware, Hono RPC/client typing, Hono validation, app.request tests, or Hono runtime adapters for Node.js, Cloudflare Workers, Bun, Deno, Vercel, Netlify, AWS Lambda, and edge runtimes.
---

# Hono

Use this skill when creating, reviewing, debugging, or refactoring Hono applications and APIs.

## Reference Docs

- Start from `https://hono.dev/llms.txt` when you need the current official AI-oriented doc index.
- Fetch `https://hono.dev/llms-small.txt` for compact docs with core concepts and examples.
- Fetch `https://hono.dev/llms-full.txt` when you need detailed API, middleware, validation, RPC, helper, or runtime-adapter behavior.
- Prefer the official docs over memory when the exact import path, middleware behavior, or runtime adapter contract matters.

## Core Patterns

- Create apps with `import { Hono } from 'hono'` and `const app = new Hono()`.
- Prefer direct route handlers after path definitions because Hono infers params and validated data best at the route site.
- Avoid Rails-style controllers typed only as `Context`; they lose route-specific type inference.
- For larger apps, split route groups into small Hono sub-apps and mount them with `app.route('/prefix', subApp)`.
- Export `export type AppType = typeof app` or `typeof route` when callers use Hono RPC via `hc`.
- Use Web Standard APIs (`Request`, `Response`, `fetch`, `URL`, `Headers`) unless the selected adapter requires something runtime-specific.

```ts
import { Hono } from 'hono'

const app = new Hono()

app.get('/', (c) => c.text('Hono!'))

export default app
```

## TypeScript Guidance

- Keep route definitions chained when RPC type inference matters.
- Return `c.json(data, status)` with explicit status codes for typed client responses, especially error responses.
- Do not use `c.notFound()` in RPC routes unless the project has augmented `NotFoundResponse`; prefer `c.json({ error: 'not found' }, 404)`.
- Use `c.req.valid('json' | 'form' | 'query' | 'param' | 'header' | 'cookie')` after validator middleware.
- Path and query inputs sent through `hc` are strings, even when validators coerce them to numbers, booleans, or dates.
- Use `import type` for `AppType`, `InferRequestType`, `InferResponseType`, and other type-only imports.

## Validation

- Use Hono validator middleware or a project-standard validator package such as `@hono/zod-validator` when inputs cross trust boundaries.
- Validate path params, query params, headers, cookies, JSON bodies, and form bodies at the route boundary.
- Use coercion intentionally for query and param values because they arrive as strings.

```ts
import { zValidator } from '@hono/zod-validator'
import { Hono } from 'hono'
import { z } from 'zod'

const app = new Hono()

const route = app.post(
  '/posts',
  zValidator(
    'json',
    z.object({
      title: z.string().min(1),
      body: z.string().min(1),
    })
  ),
  (c) => {
    const input = c.req.valid('json')
    return c.json({ ok: true, title: input.title }, 201)
  }
)

export type AppType = typeof route
```

## Middleware

- Use `app.use()` for cross-cutting concerns such as request IDs, logging, CORS, auth, secure headers, timing, and context variables.
- Keep middleware small and composable; call `await next()` exactly once unless deliberately short-circuiting.
- Set typed variables with Hono generics when downstream handlers need `c.var` or `c.get()` values.
- Prefer built-in middleware imports such as `hono/cors`, `hono/logger`, `hono/secure-headers`, `hono/request-id`, and `hono/timing` when they fit.

```ts
import { Hono } from 'hono'

type Variables = {
  requestId: string
}

const app = new Hono<{ Variables: Variables }>()

app.use('*', async (c, next) => {
  c.set('requestId', crypto.randomUUID())
  await next()
})

app.get('/health', (c) => c.json({ requestId: c.var.requestId }, 200))
```

## RPC Client

- Create clients with `hc<AppType>(baseUrl)` from `hono/client`.
- Import `AppType` with `import type` from the server route module or a shared type export.
- Use `InferRequestType` and `InferResponseType` when deriving client call types.
- For cookies, configure the client with `init: { credentials: 'include' }`.
- Use `$path()` for path strings and `$url()` only with an absolute base URL.

```ts
import { hc } from 'hono/client'
import type { AppType } from './server'

const client = hc<AppType>('http://localhost:8787/')

const res = await client.posts.$post({
  json: {
    title: 'Hello',
    body: 'Hono is fast',
  },
})

if (res.status === 201) {
  const data = await res.json()
  console.log(data.ok)
}
```

## Testing

- Prefer `app.request()` for route-level tests; it works without binding to a port.
- Test status codes, response body shape, and important headers.
- Test both success and expected failure paths for validators and auth middleware.
- For HEAD behavior, remember Hono automatically handles HEAD via GET and strips the body; test GET and HEAD separately if HEAD matters.

```ts
import { describe, expect, it } from 'vitest'
import app from './app'

describe('GET /health', () => {
  it('returns health status', async () => {
    const res = await app.request('/health')

    expect(res.status).toBe(200)
    await expect(res.json()).resolves.toEqual({ ok: true })
  })
})
```

## Runtime Adapters

- Check the target runtime before changing entrypoints or exports.
- For Cloudflare Workers, apps are usually exported as the default fetch handler or wrapped by Worker-specific setup.
- For Node.js, use the project-standard adapter, commonly `@hono/node-server`, instead of assuming `app.listen()` exists.
- For AWS Lambda, Lambda@Edge, Vercel, Netlify, Bun, Deno, and other edge/serverless targets, confirm the official adapter import and handler shape from the docs.
- Avoid runtime-specific APIs in route code unless the app is intentionally tied to that runtime.

## Common Pitfalls

- Do not extract handlers into untyped `Context` functions when route param inference matters.
- Do not forget `await next()` in middleware that should pass control to later middleware or handlers.
- Do not parse request bodies more than once; `Request` bodies are streams.
- Do not rely on truthiness for required validated fields; let schemas express required and optional fields.
- Do not assume `c.req.param()` values are URL-decoded exactly how a domain object expects; validate and normalize them.
- Do not add broad CORS, auth bypasses, or permissive headers without confirming the intended security model.

## Working In This Repository

- Read the package `package.json` before assuming scripts, runtime adapter, dependencies, or test command names.
- Follow existing Hono route, middleware, validation, and error-response patterns in the package being edited.
- In this monorepo, use `pnpm` and package-scoped commands where possible.
- For Hono API changes, run targeted typecheck/tests for the affected package, then the repository's default quality command when appropriate.
