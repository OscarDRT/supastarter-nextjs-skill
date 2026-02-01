# Deployment (Next.js)

Deploy and production for supastarter Next.js.

## Patterns

- **Platforms**: Vercel (recommended), Netlify, Railway, or self-hosted (Docker).
- **Env**: Set all required env vars (DATABASE_URL, AUTH_SECRET, NEXT_PUBLIC_APP_URL, payment and storage vars); no secrets in repo.
- **DB**: Run migrations before or on deploy; use Neon, Supabase, PlanetScale, or RDS for PostgreSQL.
- **Webhooks**: Configure payment provider webhook URL and secret for production.
- **Domain / SSL**: Configure domain and SSL on platform.

## Key Paths

- App: `apps/web/` (build output)
- Env: platform env config (see [assets/env.example](../assets/env.example))

## Docs

- [Deployment](https://supastarter.dev/docs/nextjs/deployment) (if present)
- [Going to production / Launch](https://supastarter.dev/docs/nextjs/launch)
