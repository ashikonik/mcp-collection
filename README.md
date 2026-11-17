# MCP Collection

[![Model Context Protocol](https://img.shields.io/badge/MCP-Standard-blue.svg)](https://modelcontextprotocol.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Cross-Platform](https://img.shields.io/badge/Platform-Universal-brightgreen.svg)]()
[![Harnesses](https://img.shields.io/badge/Agents-OpenCode%20|%20Cline%20|%20Claude%20|%20Cursor%20|%20Windsurf%20|%20agy-orange.svg)]()

A curated, unified, and **100% universal collection of Model Context Protocol (MCP) servers** designed to run seamlessly in **any AI agent harness**:
- 🤖 **OpenCode** (`~/.config/opencode/mcp.json`)
- 💻 **Cline & Roo Code** (VS Code / VSCodium extension settings)
- 🧠 **Claude Code & Claude Desktop** (`~/.claude.json` / `claude_desktop_config.json`)
- ⚡ **Cursor IDE** (`~/.cursor/mcp.json`)
- 🌊 **Windsurf IDE** (`~/.codeium/windsurf/mcp_config.json`)
- 🚀 **Google Antigravity (`agy`)** (`agy mcp`)

---

## 🛠️ The 15 MCP Servers

| # | Name | Category | Transport | Execution / Command | Description |
|---|:---|:---|:---|:---|:---|
| 1 | **`skills-library`** | Workspace | `stdio` | `node dist/index.js` | Searches and installs 1,000+ skills and 100+ agents into coding harnesses |
| 2 | **`toolshed`** | Workspace | `stdio` | `node dist/index.js` | Unified capability registry and proxy across local machine corpora |
| 3 | **`orchestrator`** | Workspace | `stdio` | `node dist/index.js` | Git task board and autonomous mission orchestrator |
| 4 | **`verifier`** | Workspace | `stdio` | `node dist/index.js` | Runs project tests and durably records verification proofs |
| 5 | **`content-creation`** | Workspace | `stdio` | `node dist/index.js` | Multimodal skills engine for video, audio, 3D, design, and text |
| 6 | **`playwright`** | Browser | `stdio` | `npx -y @playwright/mcp@latest` | Headless/live browser automation, DOM interaction, screenshots |
| 7 | **`chrome-devtools`** | Browser | `stdio` | `npx -y chrome-devtools-mcp@latest` | Chromium DevTools inspection (DOM, console, network, memory) |
| 8 | **`memory`** | Memory | `stdio` | `npx -y @modelcontextprotocol/server-memory` | Graph-based persistent memory (entities, relations, observations) |
| 9 | **`sequential-thinking`** | Reasoning | `stdio` | `npx -y @modelcontextprotocol/server-sequential-thinking` | Dynamic step-by-step thinking for deep problem solving |
| 10 | **`squish`** | Memory | `stdio` | `npx -y squish-memory` | Ultra-fast local SQLite memory runtime (<20ms latency) |
| 11 | **`token-optimizer`** | Performance | `stdio` | `npx -y token-optimizer-mcp` | Context deduplication and 95%+ compression |
| 12 | **`omega-memory`** | Memory | `stdio` | `uvx omega-memory serve` | Vector semantic search + hybrid knowledge graph recall |
| 13 | **`longhand`** | Memory | `stdio` | `longhand mcp-server` | Lossless session recorder capturing tool calls & reasoning |
| 14 | **`evalview`** | Testing | `stdio` | `python3 -m evalview mcp serve` | AI agent regression testing and output quality verification |
| 15 | **`devfleet`** | Multi-Agent | `http` | `http://localhost:18801/mcp` | Dispatches parallel agents across isolated git worktrees |

---

## ⚡ Quick Start

### 1. Universal Health Check
Detects your OS, verifies essential runtimes (`node`, `npm`, `npx`, `python3`, `uvx`, `git`), and scans which AI agent harnesses are installed:

```bash
bash scripts/test-health.sh
# or
npm run test:health
```

### 2. Universal Setup Script
Automatically configures all detected agents, or targets specific ones:

```bash
# Auto-configure all detected agents on your system
bash scripts/setup.sh

# Or configure specific agents:
npm run setup:opencode   # Configures ~/.config/opencode/mcp.json
npm run setup:cline      # Configures VS Code / VSCodium Cline & Roo Code
npm run setup:claude     # Configures Claude Code & Claude Desktop
npm run setup:cursor     # Configures Cursor IDE
npm run setup:windsurf   # Configures Windsurf IDE
npm run setup:agy        # Registers all servers in Antigravity (agy mcp)
```

> **Using only the zero-config packages?**  
> If you don't have the 5 local workspace repos cloned and only want the 10 standalone npm/uvx servers, run:
> ```bash
> bash scripts/setup.sh --only-universal
> ```

---

## 📁 Repository Structure

```
mcp-collection/
├── README.md                 # Primary guide and documentation
├── LICENSE                   # MIT License
├── package.json              # Project definition & npm run scripts
├── configs/
│   ├── opencode_mcp.json     # Ready for OpenCode
│   ├── cline_mcp_settings.json # Ready for Cline / Roo Code
│   ├── claude_desktop.json   # Ready for Claude Code / Desktop
│   ├── cursor_mcp.json       # Ready for Cursor IDE
│   ├── windsurf_mcp.json     # Ready for Windsurf IDE
│   └── mcp-servers.json      # Master schema definition
├── docs/
│   ├── local-servers.md      # Detailed docs for local workspace servers
│   ├── memory-agents.md      # Memory, reasoning & evaluation servers
│   └── browser-tools.md      # Browser automation tools
└── scripts/
    ├── setup.sh              # Universal multi-agent setup script
    ├── setup-agy.sh          # Legacy shortcut for agy setup
    ├── test-health.sh        # Universal health check & agent detector
    └── generate-configs.py   # Dynamic cross-platform config generator
```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
