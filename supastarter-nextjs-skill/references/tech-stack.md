# Tech Stack (Next.js)

Overview of the supastarter Next.js stack. **Next.js only**; no Vue/Nuxt.

## Stack Summary

- **Framework**: Next.js 14+ (App Router, Route Handlers), React 18+, TypeScript
- **Backend / Data**: Prisma or Drizzle, Hono, oRPC, PostgreSQL
- **Auth**: Better Auth
- **Payments**: Stripe / Lemonsqueezy / Polar
- **UI**: Tailwind CSS, Radix UI / shadcn/ui
- **Tooling**: TurboRepo, TanStack Query, Vercel AI SDK (optional), content-collections (blog/docs)

## Key Paths

- App: `apps/web/` (app/, components/, config/, lib/)
- API: `packages/api/` (Hono + oRPC)
- Database: `packages/database/` (Prisma schema, migrations, queries)
- Auth: `packages/auth/`
- Shared UI: `packages/ui/`

## Docs

- [Tech Stack](https://supastarter.dev/docs/nextjs/tech-stack)
- [Introduction](https://supastarter.dev/docs/nextjs)
