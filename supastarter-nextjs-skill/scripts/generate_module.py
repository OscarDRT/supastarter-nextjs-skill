#!/usr/bin/env python3
"""
Scaffold a new API module for supastarter Next.js (oRPC).

Creates packages/api/modules/<name>/ with:
  - types.ts (Zod schema stub)
  - procedures/create.ts (publicProcedure create stub)
  - router.ts (router object)

Usage (run from supastarter monorepo root):
  python scripts/generate_module.py <module-name>

Example:
  python scripts/generate_module.py feedback

After running, mount the new router in packages/api/orpc/router.ts:
  import { <name>Router } from "../modules/<name>/router";
  // In router: <name>: <name>Router
"""

import argparse
import os
import sys
from pathlib import Path


def kebab_to_pascal(s: str) -> str:
    return "".join(word.capitalize() for word in s.split("-"))


def main() -> int:
    parser = argparse.ArgumentParser(description="Scaffold a new API module (oRPC)")
    parser.add_argument("name", help="Module name (e.g. feedback, user-settings)")
    args = parser.parse_args()

    name = args.name.strip().lower().replace(" ", "-")
    if not name or not name.replace("-", "").isalnum():
        print("Error: module name must be alphanumeric (hyphens allowed)", file=sys.stderr)
        return 1

    # Assume run from monorepo root
    api_root = Path("packages/api")
    if not api_root.is_dir():
        print("Error: packages/api not found. Run from supastarter monorepo root.", file=sys.stderr)
        return 1

    module_dir = api_root / "modules" / name
    if module_dir.exists():
        print(f"Error: {module_dir} already exists", file=sys.stderr)
        return 1

    procedures_dir = module_dir / "procedures"
    procedures_dir.mkdir(parents=True, exist_ok=True)

    pascal = kebab_to_pascal(name)

    types_content = f'''import {{ z }} from "zod";

export const {name}Schema = z.object({{
  // Define input shape
}});

export type {pascal}FormValues = z.infer<typeof {name}Schema>;
'''

    create_content = f'''import {{ ORPCError }} from "@orpc/server";
import {{ z }} from "zod";
import {{ publicProcedure }} from "../../orpc/procedures";
import {{ {name}Schema }} from "../types";

export const create{pascal}Procedure = publicProcedure
  .route({{
    method: "POST",
    path: "/{name}",
    tags: ["{pascal}"],
    summary: "Create {name}",
    description: "Create a new {name} record",
  }})
  .input({name}Schema)
  .output(
    z.object({{
      id: z.string(),
    }})
  )
  .handler(async ({{ input, context }}) => {{
    // TODO: get session if needed: auth.api.getSession({{ headers: context.headers }})
    // TODO: call @repo/database create function
    throw new ORPCError("NOT_IMPLEMENTED", {{ message: "Implement create handler" }});
  }});
'''

    router_content = f'''import {{ create{pascal}Procedure }} from "./procedures/create";

export const {name}Router = {{
  create: create{pascal}Procedure,
}};
'''

    (module_dir / "types.ts").write_text(types_content.strip() + "\n", encoding="utf-8")
    (module_dir / "procedures" / "create.ts").write_text(create_content.strip() + "\n", encoding="utf-8")
    (module_dir / "router.ts").write_text(router_content.strip() + "\n", encoding="utf-8")

    print(f"Created {module_dir}")
    print("Next: mount the router in packages/api/orpc/router.ts")
    print(f"  import {{ {name}Router }} from \"../modules/{name}/router\";")
    print(f"  // In router object: {name}: {name}Router")
    return 0


if __name__ == "__main__":
    sys.exit(main())
