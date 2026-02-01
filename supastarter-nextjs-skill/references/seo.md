# SEO (Next.js)

Meta tags, sitemap, and structured data in supastarter Next.js.

## Patterns

- **Base metadata**: Root layout `apps/web/app/layout.tsx` (metadata export or generateMetadata).
- **Per-page**: `generateMetadata` in page files for title, description, openGraph.
- **Sitemap**: `apps/web/sitemap.ts` (or under app router) for dynamic sitemap.
- **Structured data**: JSON-LD or other structured data in layout or page as needed.

## Key Paths

- Root layout: `apps/web/app/layout.tsx`
- Sitemap: `apps/web/sitemap.ts`
- Page metadata: `apps/web/app/**/page.tsx` (generateMetadata)

## Docs

- [Meta tags](https://supastarter.dev/docs/nextjs/seo/meta-tags)
- [Sitemap](https://supastarter.dev/docs/nextjs/seo/sitemap)
