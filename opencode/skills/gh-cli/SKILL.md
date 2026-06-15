---
name: gh-cli
description: Use when given a GitHub URL (github.com/...) or asked to interact with GitHub — PRs, issues, repos, workflows, releases, gists. Prefer gh CLI over WebFetch or browser navigation for all github.com resources.
---

# GitHub CLI (gh)

Always prefer `gh` over WebFetch or curl for github.com URLs. The CLI is authenticated and returns structured data.

## Core patterns

```bash
# View any GitHub URL directly
gh browse <url>           # open in browser
gh api <path>             # raw REST call, e.g. gh api repos/owner/repo

# PRs
gh pr view <number|url>
gh pr list --repo <owner/repo>
gh pr checkout <number|url>
gh pr diff <number|url>
gh pr review <number|url> --approve --body "..."
gh pr comment <number|url> --body "..."
gh pr merge <number|url> --squash --auto

# Issues
gh issue view <number|url>
gh issue list --repo <owner/repo> --state open
gh issue comment <number|url> --body "..."
gh issue close <number|url>

# Repos
gh repo view <owner/repo>
gh repo clone <owner/repo>

# Workflows / Actions
gh run list --repo <owner/repo>
gh run view <run-id>
gh run watch <run-id>
gh workflow run <workflow> --repo <owner/repo>

# Releases
gh release list --repo <owner/repo>
gh release view <tag> --repo <owner/repo>

# Gists
gh gist list
gh gist view <id>
```

## Parsing GitHub URLs

Extract owner/repo/number from any github.com URL before issuing commands:

| URL pattern | Command |
|---|---|
| `github.com/owner/repo` | `gh repo view owner/repo` |
| `github.com/owner/repo/pull/123` | `gh pr view 123 --repo owner/repo` |
| `github.com/owner/repo/issues/456` | `gh issue view 456 --repo owner/repo` |
| `github.com/owner/repo/actions/runs/789` | `gh run view 789 --repo owner/repo` |
| `github.com/owner/repo/releases/tag/v1.0` | `gh release view v1.0 --repo owner/repo` |

## JSON output

Add `--json <fields>` to most commands for machine-readable output:

```bash
gh pr view 123 --repo owner/repo --json number,title,state,body,reviews,comments
gh issue view 456 --repo owner/repo --json number,title,body,labels,assignees
gh run view 789 --repo owner/repo --json status,conclusion,jobs
```

List available fields: `gh pr view --help` (shows `--json` field list).

## Checking auth

```bash
gh auth status   # confirm authenticated and which account
```

If not authenticated, the user must run `gh auth login` interactively — do not attempt to authenticate programmatically.
