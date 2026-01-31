# Common supastarter Code Patterns

This reference contains frequently used code patterns and examples for building features in supastarter.

## Database Patterns (Prisma)

### Creating a New Model

```prisma
// packages/database/prisma/schema.prisma

model YourFeature {
  id        String   @id @default(cuid())
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  
  // Relations
  userId         String
  user           User   @relation(fields: [userId], references: [id], onDelete: Cascade)
  
  organizationId String?
  organization   Organization? @relation(fields: [organizationId], references: [id], onDelete: Cascade)
  
  // Fields
  title       String
  description String?
  status      FeatureStatus @default(ACTIVE)
  
  @@index([userId])
  @@index([organizationId])
}

enum FeatureStatus {
  ACTIVE
  INACTIVE
  ARCHIVED
}
```

### Query Patterns

```typescript
import { prisma } from '@/lib/prisma'

// Find with relations
const item = await prisma.yourFeature.findUnique({
  where: { id },
  include: {
    user: true,
    organization: true,
  },
})

// Find many with filters
const items = await prisma.yourFeature.findMany({
  where: {
    organizationId,
    status: 'ACTIVE',
  },
  orderBy: { createdAt: 'desc' },
  take: 10,
})

// Create with transaction
await prisma.$transaction(async (tx) => {
  const feature = await tx.yourFeature.create({
    data: {
      title,
      userId,
      organizationId,
    },
  })
  
  // Additional operations
  await tx.auditLog.create({
    data: {
      action: 'CREATE_FEATURE',
      featureId: feature.id,
    },
  })
  
  return feature
})
```

## API Patterns (Hono.js)

### Basic Route Setup

```typescript
// packages/api/src/routes/features.ts
import { Hono } from 'hono'
import { zValidator } from '@hono/zod-validator'
import { z } from 'zod'

const app = new Hono()

// GET list
app.get('/', async (c) => {
  const organizationId = c.get('organizationId') // From auth middleware
  
  const features = await prisma.yourFeature.findMany({
    where: { organizationId },
  })
  
  return c.json({ features })
})

// POST create
const createSchema = z.object({
  title: z.string().min(1).max(100),
  description: z.string().optional(),
})

app.post('/', zValidator('json', createSchema), async (c) => {
  const { title, description } = c.req.valid('json')
  const userId = c.get('userId')
  const organizationId = c.get('organizationId')
  
  const feature = await prisma.yourFeature.create({
    data: {
      title,
      description,
      userId,
      organizationId,
    },
  })
  
  return c.json({ feature }, 201)
})

// GET single
app.get('/:id', async (c) => {
  const id = c.req.param('id')
  const organizationId = c.get('organizationId')
  
  const feature = await prisma.yourFeature.findFirst({
    where: { 
      id,
      organizationId, // Ensure user can only access their org's data
    },
  })
  
  if (!feature) {
    return c.json({ error: 'Not found' }, 404)
  }
  
  return c.json({ feature })
})

// PATCH update
app.patch('/:id', zValidator('json', createSchema.partial()), async (c) => {
  const id = c.req.param('id')
  const data = c.req.valid('json')
  const organizationId = c.get('organizationId')
  
  const feature = await prisma.yourFeature.updateMany({
    where: { 
      id,
      organizationId,
    },
    data,
  })
  
  return c.json({ feature })
})

// DELETE
app.delete('/:id', async (c) => {
  const id = c.req.param('id')
  const organizationId = c.get('organizationId')
  
  await prisma.yourFeature.deleteMany({
    where: { 
      id,
      organizationId,
    },
  })
  
  return c.json({ success: true })
})

export default app
```

### Registering Routes

```typescript
// packages/api/src/index.ts
import { Hono } from 'hono'
import features from './routes/features'

const app = new Hono()

app.route('/api/features', features)

export default app
```

## Frontend Patterns (Next.js)

### Server Component with Data Fetching

```typescript
// apps/web/app/(app)/[organizationSlug]/features/page.tsx
import { prisma } from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'
import { FeatureList } from '@/components/features/feature-list'

export default async function FeaturesPage({
  params,
}: {
  params: { organizationSlug: string }
}) {
  const user = await getCurrentUser()
  
  const organization = await prisma.organization.findUnique({
    where: { slug: params.organizationSlug },
  })
  
  if (!organization) {
    notFound()
  }
  
  const features = await prisma.yourFeature.findMany({
    where: { organizationId: organization.id },
    orderBy: { createdAt: 'desc' },
  })
  
  return (
    <div>
      <h1>Features</h1>
      <FeatureList features={features} />
    </div>
  )
}
```

### Client Component with TanStack Query

```typescript
// apps/web/components/features/feature-list.tsx
'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { api } from '@/lib/api-client'

export function FeatureList() {
  const queryClient = useQueryClient()
  
  // Fetch data
  const { data, isLoading } = useQuery({
    queryKey: ['features'],
    queryFn: async () => {
      const res = await api.get('/api/features')
      return res.json()
    },
  })
  
  // Create mutation
  const createMutation = useMutation({
    mutationFn: async (newFeature: { title: string }) => {
      const res = await api.post('/api/features', {
        json: newFeature,
      })
      return res.json()
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['features'] })
    },
  })
  
  // Delete mutation
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      await api.delete(`/api/features/${id}`)
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['features'] })
    },
  })
  
  if (isLoading) return <div>Loading...</div>
  
  return (
    <div>
      {data?.features.map((feature) => (
        <div key={feature.id}>
          <h3>{feature.title}</h3>
          <button onClick={() => deleteMutation.mutate(feature.id)}>
            Delete
          </button>
        </div>
      ))}
    </div>
  )
}
```

### Form with Server Actions

```typescript
// apps/web/app/(app)/[organizationSlug]/features/new/page.tsx
import { redirect } from 'next/navigation'
import { getCurrentUser } from '@/lib/auth'
import { prisma } from '@/lib/prisma'

async function createFeature(formData: FormData) {
  'use server'
  
  const user = await getCurrentUser()
  const title = formData.get('title') as string
  const organizationId = formData.get('organizationId') as string
  
  await prisma.yourFeature.create({
    data: {
      title,
      userId: user.id,
      organizationId,
    },
  })
  
  redirect(`/org/${organizationId}/features`)
}

export default function NewFeaturePage() {
  return (
    <form action={createFeature}>
      <input name="title" type="text" required />
      <input name="organizationId" type="hidden" value="..." />
      <button type="submit">Create</button>
    </form>
  )
}
```

## UI Components (shadcn/ui)

### Using Built-in Components

```typescript
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'

export function FeatureCard() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Create Feature</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          <div>
            <Label htmlFor="title">Title</Label>
            <Input id="title" name="title" />
          </div>
          <Button type="submit">Submit</Button>
        </div>
      </CardContent>
    </Card>
  )
}
```

### Custom Component Pattern

```typescript
// apps/web/components/features/feature-card.tsx
import { Card } from '@/components/ui/card'
import type { YourFeature } from '@prisma/client'

interface FeatureCardProps {
  feature: YourFeature
  onDelete?: (id: string) => void
}

export function FeatureCard({ feature, onDelete }: FeatureCardProps) {
  return (
    <Card className="p-4">
      <h3 className="text-lg font-semibold">{feature.title}</h3>
      {feature.description && (
        <p className="text-sm text-muted-foreground mt-2">
          {feature.description}
        </p>
      )}
      {onDelete && (
        <button
          onClick={() => onDelete(feature.id)}
          className="mt-4 text-sm text-destructive hover:underline"
        >
          Delete
        </button>
      )}
    </Card>
  )
}
```

## Authentication Patterns

### Protecting Routes (Middleware)

```typescript
// apps/web/middleware.ts
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { getSession } from '@/lib/auth'

export async function middleware(request: NextRequest) {
  const session = await getSession()
  
  // Check if user is authenticated
  if (!session) {
    return NextResponse.redirect(new URL('/login', request.url))
  }
  
  // Check organization membership
  const organizationSlug = request.nextUrl.pathname.split('/')[2]
  if (organizationSlug) {
    const hasAccess = await checkOrganizationAccess(
      session.userId,
      organizationSlug
    )
    
    if (!hasAccess) {
      return NextResponse.redirect(new URL('/unauthorized', request.url))
    }
  }
  
  return NextResponse.next()
}

export const config = {
  matcher: ['/app/:path*', '/admin/:path*'],
}
```

### Getting Current User

```typescript
// apps/web/lib/auth.ts
import { auth } from '@/lib/better-auth'

export async function getCurrentUser() {
  const session = await auth.api.getSession({
    headers: headers(),
  })
  
  if (!session) {
    redirect('/login')
  }
  
  return session.user
}
```

## Organization Patterns

### Organization Context

```typescript
// apps/web/components/providers/organization-provider.tsx
'use client'

import { createContext, useContext } from 'react'
import type { Organization } from '@prisma/client'

const OrganizationContext = createContext<Organization | null>(null)

export function useOrganization() {
  const context = useContext(OrganizationContext)
  if (!context) {
    throw new Error('useOrganization must be used within OrganizationProvider')
  }
  return context
}

export function OrganizationProvider({
  organization,
  children,
}: {
  organization: Organization
  children: React.ReactNode
}) {
  return (
    <OrganizationContext.Provider value={organization}>
      {children}
    </OrganizationContext.Provider>
  )
}
```

### Role-Based Access Control

```typescript
// apps/web/lib/permissions.ts
export enum OrganizationRole {
  OWNER = 'OWNER',
  ADMIN = 'ADMIN',
  MEMBER = 'MEMBER',
}

export function canManageMembers(role: OrganizationRole) {
  return role === OrganizationRole.OWNER || role === OrganizationRole.ADMIN
}

export function canManageBilling(role: OrganizationRole) {
  return role === OrganizationRole.OWNER
}

// Usage in components
export function MemberSettings() {
  const { organization, userRole } = useOrganization()
  
  if (!canManageMembers(userRole)) {
    return <div>You don't have permission to manage members</div>
  }
  
  return <MemberManagementUI />
}
```
