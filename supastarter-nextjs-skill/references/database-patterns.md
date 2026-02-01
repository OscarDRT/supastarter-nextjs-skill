# Database Patterns (Next.js)

Prisma schema, migrations, and queries in supastarter Next.js.

## Patterns

- **Schema**: Define models in `packages/database/prisma/schema.prisma`; add relations (e.g. User → Feedback).
- **Migrations**: `pnpm --filter database migrate` (or `db:migrate` from root); push: `pnpm --filter database push`.
- **Client**: `pnpm --filter database generate`; use `db` or exported client from `@repo/database`; do not instantiate Prisma in app code.
- **Queries**: Dedicated files under `packages/database/prisma/queries/` (e.g. `feedback.ts`); export from `queries/index.ts`.
- **Studio**: `pnpm --filter database studio`.

## Key Paths

- Schema: `packages/database/prisma/schema.prisma`
- Queries: `packages/database/prisma/queries/*.ts`, `queries/index.ts`
- Client: `packages/database/` (client export)

## Docs

- [Database overview](https://supastarter.dev/docs/nextjs/database/overview)
- [Client](https://supastarter.dev/docs/nextjs/database/client)
- [Update schema & migrate](https://supastarter.dev/docs/nextjs/database/update-schema)
- [Database studio](https://supastarter.dev/docs/nextjs/database/studio)
