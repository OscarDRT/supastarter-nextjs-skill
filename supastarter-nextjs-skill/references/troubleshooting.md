# Troubleshooting (Next.js)

Common issues and debugging for supastarter Next.js.

## Patterns

- **DB connection**: Check `DATABASE_URL` format and that DB is running; ensure migrations applied.
- **Auth**: Verify `AUTH_SECRET`, callback URLs, session cookie settings.
- **Payments**: Webhook secret, endpoint reachability, provider logs.
- **Build**: Clear `.next` and `node_modules`; regenerate Prisma client; fix TypeScript errors.
- **Deps**: Run from monorepo root (`pnpm install`, `pnpm --filter <workspace> ...`).

## Key Paths

- Logs: app and API logging as configured in `packages/api` and `apps/web`
- DB: `packages/database/` (client, schema, migrations)
- Auth: `packages/auth/`

## Docs

- [Troubleshooting](https://supastarter.dev/docs/nextjs/troubleshooting)
