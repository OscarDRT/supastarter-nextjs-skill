# Configuration (Next.js)

Environment variables, app config, and feature flags for supastarter Next.js.

## Patterns

- **Env**: `.env` at root or app; use `DATABASE_URL`, `AUTH_SECRET`, `NEXT_PUBLIC_APP_URL`, payment and storage vars (see [assets/env.example](../assets/env.example)).
- **App config**: `apps/web/config/` – site metadata, payment plans, feature flags.
- **Shared config**: `packages/config/` for shared settings and i18n locale config.

## Key Paths

- Env: root `.env` or `apps/web/.env`
- App config: `apps/web/config/site.ts`, `payment.ts`, `features.ts`
- Shared: `packages/config/index.ts`

## Docs

- [Configuration](https://supastarter.dev/docs/nextjs/configuration)
