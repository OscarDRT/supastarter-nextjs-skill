# Monitoring (Next.js)

Monitoring and error tracking in supastarter Next.js.

## Patterns

- **Errors**: Error boundaries in app; optional error reporting service (e.g. Sentry) in layout or global handler.
- **Logging**: Structured logs in API and server code; use `@repo/logs` or equivalent if present.
- **Health**: Optional health check route (e.g. `apps/web/app/api/health/route.ts`) for DB and critical deps.

## Key Paths

- Error boundary: `apps/web/app/error.tsx`, `global-error.tsx`
- Logs: `packages/api/`, `packages/logs/` (if present)
- Health: `apps/web/app/api/health/` (if present)

## Docs

- [Monitoring](https://supastarter.dev/docs/nextjs/monitoring) (or equivalent path)
