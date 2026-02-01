# Mailing Patterns (Next.js)

Emails, templates, and providers in supastarter Next.js.

## Patterns

- **Templates**: React Email in `packages/mail/templates` (or `emails/`); shared Tailwind config for email.
- **Providers**: Plunk, Resend, Postmark, Nodemailer, Console (dev), or custom; config in `packages/mail/`.
- **Config**: `packages/mail/config/index.ts` (or equivalent).
- **Preview**: `pnpm --filter mail preview` to preview templates.

## Key Paths

- Templates: `packages/mail/templates` or `packages/mail/emails`
- Provider: `packages/mail/provider`
- Config: `packages/mail/config/index.ts`

## Docs

- [Mailing overview](https://supastarter.dev/docs/nextjs/mailing/overview)
- Providers and setup per docs
