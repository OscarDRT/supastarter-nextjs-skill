# Auth Patterns (Next.js)

Better Auth, session, and protected endpoints in supastarter Next.js.

## Patterns

- **Config**: Better Auth lives in `packages/auth/`; adapter for DB in `packages/auth/auth.ts`.
- **Session**: Server: `auth.api.getSession({ headers })`; client: `useSession` from `@saas/auth/hooks/use-session` (or equivalent).
- **Protected routes**: Use protected oRPC procedures or middleware; redirect unauthenticated users in app routes/middleware.
- **OAuth / magic link**: Configure in auth config; callback URLs must match app URL.

## Key Paths

- Auth config: `packages/auth/` (auth.ts, config)
- Auth routes (UI): `apps/web/app/(auth)/`
- Session hooks: app auth hooks (e.g. `useSession`)

## Docs

- [Authentication overview](https://supastarter.dev/docs/nextjs/authentication/overview)
- [User and session](https://supastarter.dev/docs/nextjs/authentication/user-and-session)
- [Permissions](https://supastarter.dev/docs/nextjs/authentication/permissions)
- [OAuth](https://supastarter.dev/docs/nextjs/authentication/oauth)
