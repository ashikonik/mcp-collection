# MCP Collection

[![Model Context Protocol](https://img.shields.io/badge/MCP-Standard-blue.svg)](https://modelcontextprotocol.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A curated, unified, and independent collection of **Model Context Protocol (MCP)** servers ready for deployment across **Google Antigravity (agy)**, **Claude Code / Claude Desktop**, **Cursor IDE**, and **OpenCode**.

---

## Overview

This repository provides ready-to-use configurations, health check scripts, and detailed documentation for **15 high-performance MCP servers** covering:

1. **Local Workspace Tools**: Skills libraries, tool registries, autonomous git task orchestrators, test verifiers, and multimodal asset generators.
2. **Browser & Visual Automation**: Full Playwright and Chrome DevTools protocol runners for testing and page analysis.
3. **Agent & Memory Architectures**: Knowledge graphs, zero-config SQLite session recall, semantic vector memory, sequential reasoning engines, and token optimizers.

---

## Server Roster

| # | Name | Category | Transport | Command / Endpoint |
|---|:---|:---|:---|:---|
| 1 | **`skills-library`** | Workspace | `stdio` | `node dist/index.js` (skills-library-mcp-public) |
| 2 | **`toolshed`** | Workspace | `stdio` | `node dist/index.js` (toolshed-mcp) |
| 3 | **`orchestrator`** | Workspace | `stdio` | `node dist/index.js` (orchestrator/mcp) |
| 4 | **`verifier`** | Workspace | `stdio` | `node dist/index.js` (verifier/mcp) |
| 5 | **`content-creation`**| Workspace | `stdio` | `node dist/index.js` (content-creation-mcp/mcp) |
| 6 | **`playwright`** | Browser | `stdio` | `npx -y @playwright/mcp@latest` |
| 7 | **`chrome-devtools`** | Browser | `stdio` | `npx -y chrome-devtools-mcp@latest` |
| 8 | **`memory`** | Memory | `stdio` | `npx -y @modelcontextprotocol/server-memory` |
| 9 | **`sequential-thinking`** | Reasoning | `stdio` | `npx -y @modelcontextprotocol/server-sequential-thinking` |
| 10 | **`squish`** | Memory | `stdio` | `npx -y squish-memory` |
| 11 | **`token-optimizer`** | Performance | `stdio` | `npx -y token-optimizer-mcp` |
| 12 | **`omega-memory`** | Memory | `stdio` | `uvx omega-memory serve` |
| 13 | **`longhand`** | Memory | `stdio` | `longhand mcp-server` |
| 14 | **`evalview`** | Evaluation | `stdio` | `python3 -m evalview mcp serve` |
| 15 | **`devfleet`** | Multi-Agent | `http` | `http://localhost:18801/mcp` |

---

## Quick Start

### 1. Verification & Health Check
Run the included verification script to check your local environment for required runtimes (`node`, `npx`, `python3`, `uvx`, `agy`):

```bash
bash scripts/test-health.sh
```

### 2. Antigravity CLI (`agy`) Setup
To automatically register all servers into your global Antigravity configuration:

```bash
bash scripts/setup-agy.sh
```

Or inspect active servers directly:
```bash
agy mcp list
```

### 3. Claude Code & Claude Desktop Setup
Copy the pre-built configuration to your Claude configuration file:

```bash
# Claude Desktop (macOS/Linux)
cp configs/claude_desktop.json ~/.config/Claude/claude_desktop_config.json
```

### 4. Cursor IDE Setup
Add the contents of `configs/cursor_mcp.json` to your Cursor Settings (`Features > MCP Servers`).

---

## Repository Structure

```
mcp-collection/
├── README.md                 # Primary guide and documentation
├── LICENSE                   # MIT License
├── package.json              # Project definition & npm run scripts
├── configs/
│   ├── mcp-servers.json      # Master schema definition
│   ├── claude_desktop.json   # Ready for Claude Desktop/Code
│   └── cursor_mcp.json       # Ready for Cursor IDE
├── docs/
│   ├── local-servers.md      # In-depth guide to local workspace servers
│   ├── memory-agents.md      # Memory, reasoning & evaluation servers
│   └── browser-tools.md      # Browser automation tools
└── scripts/
    ├── setup-agy.sh          # One-click registration script for agy
    └── test-health.sh        # Dependency and path health check script
```

---

## License

This project is licensed under the [MIT License](LICENSE).
