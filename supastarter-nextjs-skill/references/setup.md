# Setup (Next.js)

Install, dependencies, and initial setup for supastarter Next.js.

## Patterns

- Use **pnpm** for install and workspaces.
- Monorepo: root `pnpm install`; workspace packages under `apps/` and `packages/`.
- Database: set `DATABASE_URL`, run `pnpm db:push` or migrations from `packages/database`.
- Local services: Docker (Postgres, MinIO) per docs; create required buckets (e.g. `avatars`).

## Key Paths

- Root: `package.json`, `turbo.json`, `pnpm-workspace.yaml`
- App: `apps/web/`
- Database: `packages/database/` (schema, migrations)

## Docs

- [Setup](https://supastarter.dev/docs/nextjs/setup)
- [Configuration](https://supastarter.dev/docs/nextjs/configuration) (env, config)
