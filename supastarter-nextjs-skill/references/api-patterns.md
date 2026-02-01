# API Patterns (Next.js)

Hono, oRPC procedures, and router in supastarter Next.js.

## Patterns

- **Modules**: One folder per feature under `packages/api/modules/<name>/` (e.g. `feedback/`).
- **Types**: Zod schemas in `modules/<name>/types.ts`; use for input/output.
- **Procedures**: `publicProcedure` or protected procedures; define in `modules/<name>/procedures/<action>.ts` (e.g. `create.ts`).
- **Router**: Export router object from `modules/<name>/router.ts`; mount in `packages/api/orpc/router.ts` under a key (e.g. `feedback: feedbackRouter`).
- **Session**: Use `auth.api.getSession({ headers })` in procedures when session is optional or required; protect with procedure middleware when required.

## Key Paths

- Router: `packages/api/orpc/router.ts`
- Modules: `packages/api/modules/<name>/` (types.ts, procedures/, router.ts)
- Procedures: `packages/api/orpc/procedures.ts` (or equivalent for publicProcedure)

## Docs

- [API overview](https://supastarter.dev/docs/nextjs/api/overview)
- [Define endpoint](https://supastarter.dev/docs/nextjs/api/define-endpoint)
- [Protect endpoints](https://supastarter.dev/docs/nextjs/api/protect-endpoints)
- [Usage in frontend](https://supastarter.dev/docs/nextjs/api/usage-in-frontend)
- [Streaming](https://supastarter.dev/docs/nextjs/api/streaming)
- [OpenAPI](https://supastarter.dev/docs/nextjs/api/openapi)
