# Analytics (Next.js)

Analytics integration in supastarter Next.js.

## Patterns

- **Client-side**: Add analytics script or SDK in root layout or `_app`; use env for API keys (e.g. `NEXT_PUBLIC_*`).
- **Server-side**: Optional server-side events via API route or server action; respect privacy and consent.
- **Paths**: Layout or provider component in `apps/web/app/` or `apps/web/components/`.

## Key Paths

- Layout: `apps/web/app/layout.tsx` (scripts, providers)
- Config: env vars for analytics keys

## Docs

- [Analytics](https://supastarter.dev/docs/nextjs/analytics) (or equivalent path)
