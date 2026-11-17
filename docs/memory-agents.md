# Agent & Memory MCP Servers

This document details the reasoning, memory, optimization, and evaluation servers in this collection.

---

## Memory Servers

### 1. `memory` (`@modelcontextprotocol/server-memory`)
- **Transport**: `stdio` (`npx -y @modelcontextprotocol/server-memory`)
- **Purpose**: Persistent knowledge-graph memory across agent conversations. Builds an entity-relationship graph with observations.
- **Key Tools**: `create_entities`, `create_relations`, `add_observations`, `read_graph`, `search_nodes`.

### 2. `squish` (`squish-memory`)
- **Transport**: `stdio` (`npx -y squish-memory`)
- **Purpose**: Ultra-fast, zero-configuration local SQLite memory runtime (sub-20ms latency, 283KB footprint). Automatically indexes context across sessions.

### 3. `omega-memory` (`omega-memory`)
- **Transport**: `stdio` (`uvx omega-memory serve`)
- **Purpose**: Enhanced persistent memory featuring vector semantic search, multi-agent synchronization, and hybrid knowledge graph recall.

### 4. `longhand` (`longhand`)
- **Transport**: `stdio` (`longhand mcp-server`)
- **Purpose**: Lossless agent history recorder. Captures raw tool calls, file diffs, and intermediate reasoning blocks before local conversation log compaction.
- **Setup**: `pip install longhand && longhand setup`

---

## Agent Reasoning, Optimization & Testing

### 1. `sequential-thinking` (`@modelcontextprotocol/server-sequential-thinking`)
- **Transport**: `stdio` (`npx -y @modelcontextprotocol/server-sequential-thinking`)
- **Purpose**: Dynamic step-by-step thinking tool for breaking down complex architectural or debugging problems with hypotheses and revisions.
- **Key Tools**: `sequentialthinking`.

### 2. `token-optimizer` (`token-optimizer-mcp`)
- **Transport**: `stdio` (`npx -y token-optimizer-mcp`)
- **Purpose**: Content deduplication and semantic compression delivering context reduction for large codebases.

### 3. `evalview` (`evalview`)
- **Transport**: `stdio` (`python3 -m evalview mcp serve`)
- **Purpose**: AI agent regression testing. Validates agent tool calls, tests prompt variants, and generates visual difference reports.
- **Setup**: `pip install evalview`

### 4. `devfleet`
- **Transport**: `http` (`http://localhost:18801/mcp`)
- **Purpose**: Dispatches parallel subagents in isolated git worktrees, collecting structured mission reports.
