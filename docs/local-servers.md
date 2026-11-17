# Local Workspace MCP Servers

This document details the locally developed and compiled MCP servers included in the collection.

---

## 1. `skills-library`
- **Location**: `skills-library-mcp-public/mcp`
- **Entrypoint**: `dist/index.js` (Node.js ESM)
- **Transport**: `stdio`
- **Purpose**: Indexes 1,000+ skills and 100+ agent archetypes from local repositories. Allows dynamic searching, document retrieval, and safe installation into target coding harnesses (e.g. Antigravity, Claude Code, Cursor, OpenCode).
- **Key Tools**:
  - `search_library`: Relevance-ranked queries across skills and agents.
  - `get_skill`: Retrieve raw Markdown / YAML content for a skill.
  - `get_agent`: Retrieve agent definitions.
  - `install_skills`: Register skills to auto-activate in a harness.
  - `uninstall_skills`: Revert installed skills.

---

## 2. `toolshed`
- **Location**: `toolshed-mcp`
- **Entrypoint**: `dist/index.js` (Node.js ESM)
- **Transport**: `stdio`
- **Purpose**: A standalone registry and capability proxy. Unifies skills, agents, commands, and MCP server endpoints discovered across multiple corpora on the system.
- **Key Tools**:
  - `search_registry`: Query all available tools and entries.
  - `get_entry`: Retrieve metadata and execution manifests for an entry.
  - `proxy_discover`: Auto-discover MCP capabilities from local environments.
  - `proxy_call`: Execute delegated tool calls via the proxy layer.

---

## 3. `orchestrator`
- **Location**: `orchestrator/mcp`
- **Entrypoint**: `dist/index.js` (Node.js ESM)
- **Transport**: `stdio`
- **Purpose**: Git repository task board and autonomous multi-turn mission orchestrator. Maintains state boards, branch planning, and task transitions without external services.
- **Key Tools**:
  - `board_get` / `board_set`: Read and update task status boards.
  - `task_create` / `task_update` / `task_claim`: Task lifecycle management.
  - `git_status` / `git_commit` / `git_worktree`: Programmatic git operations for agent isolation.

---

## 4. `verifier`
- **Location**: `verifier/mcp`
- **Entrypoint**: `dist/index.js` (Node.js ESM)
- **Transport**: `stdio`
- **Purpose**: Durable verification engine that executes project test suites, linters, and custom assertions, preserving verification evidence across runs.
- **Key Tools**:
  - `verify_run`: Execute a configured verification suite.
  - `verify_record`: Record test run outcomes and logs.
  - `verify_list`: Inspect historic verification results.

---

## 5. `content-creation`
- **Location**: `content-creation-mcp/mcp`
- **Entrypoint**: `dist/index.js` (Node.js ESM)
- **Transport**: `stdio` (also supports HTTP via `dist/http.js`)
- **Purpose**: Multimodal creation server exposing specialized skills and agents for media domains (video, audio, text, 3D, and design).
- **Key Tools**:
  - `list_skills` / `get_skill`: Browse and fetch domain skills.
  - `render_skill`: Dynamic rendering into target agent frontmatter dialects (Claude, OpenAI YAML, Cursor, Markdown).
  - `list_modalities`: Query supported media workflows.
