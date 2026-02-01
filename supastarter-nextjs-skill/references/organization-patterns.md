# Organization Patterns (Next.js)

Organizations, roles, and multi-tenancy in supastarter Next.js.

## Patterns

- **Schema**: User–organization relations and roles in `packages/database/prisma/schema.prisma`.
- **Scoping**: Organization context/provider in app; access control helpers in `apps/web/modules/saas/*/lib`.
- **Routes**: Organization-scoped routes under `apps/web/app/(app)/[organizationSlug]/`.
- **Billing**: Seat-based billing per organization; link to payment provider.

## Key Paths

- Schema: `packages/database/prisma/schema.prisma` (Organization, Member, roles)
- App routes: `apps/web/app/(app)/[organizationSlug]/`
- SaaS modules: `apps/web/modules/saas/`

## Docs

- [Organizations overview](https://supastarter.dev/docs/nextjs/organizations/overview)
- [Configure organizations](https://supastarter.dev/docs/nextjs/organizations/configure)
- [Use organizations](https://supastarter.dev/docs/nextjs/organizations/use-organizations)
- [Store data for organizations](https://supastarter.dev/docs/nextjs/organizations/store-data-for-organizations)
