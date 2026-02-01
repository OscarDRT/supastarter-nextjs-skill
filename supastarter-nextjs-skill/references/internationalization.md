# Internationalization (Next.js)

i18n, locales, and translations in supastarter Next.js.

## Patterns

- **Translations**: JSON files in `packages/i18n/translations/` (e.g. `en.json`, `de.json`); keys by feature (e.g. `feedback.*`).
- **Usage**: Server: `getTranslations` from `next-intl/server`; client: `useTranslations` from `next-intl`.
- **Locale config**: `packages/config/` (e.g. i18n locales, default locale).
- **Routing**: Localized routes per next-intl; respect locale in API when needed (see API docs).

## Key Paths

- Translations: `packages/i18n/translations/{en,de}.json`
- Locale config: `packages/config/index.ts` (or i18n config in app)
- Content: `apps/web/content/` (content-collections with locale)

## Docs

- [Internationalization](https://supastarter.dev/docs/nextjs/internationalization)
