# Storage Patterns (Next.js)

File and object storage (e.g. S3) in supastarter Next.js.

## Patterns

- **Provider**: S3-compatible storage; config and provider in `packages/storage/`.
- **Uploads**: Presigned URLs or direct upload; API routes or procedures for generating presigned URLs; client helpers for upload.
- **Env**: `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`, `S3_BUCKET`, `S3_REGION`, `S3_ENDPOINT` (for MinIO/local).
- **Buckets**: Create required buckets (e.g. `avatars`) in MinIO or provider console.

## Key Paths

- Storage package: `packages/storage/` (config, provider)
- Upload logic: API procedures or route handlers + client helpers

## Docs

- [Storage overview](https://supastarter.dev/docs/nextjs/storage/overview)
- [Setup / connect](https://supastarter.dev/docs/nextjs/storage/setup)
- [Upload files](https://supastarter.dev/docs/nextjs/storage/upload-files)
- [Access files](https://supastarter.dev/docs/nextjs/storage/access-files)
