# Customization (Next.js)

UI components, theming, and extensions in supastarter Next.js.

## Patterns

- **Styling**: `apps/web/app/globals.css`, `apps/web/tailwind.config.ts`; design tokens in theme CSS.
- **Components**: shadcn/ui and Radix; shared UI in `packages/ui/`; app components in `apps/web/components/` or `apps/web/modules/`.
- **Dashboard**: Pages under `apps/web/app/(app)/`; layout and navigation as in docs.
- **Onboarding**: Steps in `apps/web/modules/onboarding/` (or equivalent).
- **Conventions**: TypeScript; named function exports; prefer Server Components; use `cn()` for class names; react-hook-form + zod for forms.

## Key Paths

- Globals: `apps/web/app/globals.css`
- Tailwind: `apps/web/tailwind.config.ts`
- Dashboard: `apps/web/app/(app)/`
- Onboarding: `apps/web/modules/onboarding/`
- Shared UI: `packages/ui/`

## Docs

- [Customization overview](https://supastarter.dev/docs/nextjs/customization/overview)
- [Styling](https://supastarter.dev/docs/nextjs/customization/styling)
- [Dashboard](https://supastarter.dev/docs/nextjs/customization/dashboard)
- [Onboarding](https://supastarter.dev/docs/nextjs/customization/onboarding)
