# Background Tasks (Next.js)

Cron and background jobs in supastarter Next.js.

## Patterns

- **Cron**: Use platform cron (Vercel Cron, etc.) or external scheduler; call API route or internal endpoint.
- **Jobs**: Long-running or async work in procedures or route handlers; or queue (e.g. BullMQ, Inngest) per project choice.
- **Paths**: Cron routes under `apps/web/app/api/` (e.g. `cron/route.ts`) or equivalent; secure with secret header or env.

## Key Paths

- Cron route: `apps/web/app/api/cron/` (or equivalent)
- Job logic: `packages/api/` or `apps/web/` as appropriate

## Docs

- [Background tasks & cron jobs](https://supastarter.dev/docs/nextjs/background-tasks) (or equivalent path)
