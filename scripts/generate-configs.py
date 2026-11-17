#!/usr/bin/env python3
"""
generate-configs.py - Universal MCP Configuration Generator

Generates ready-to-use configuration files for any MCP-capable client:
- OpenCode
- Cline / Roo Code
- Claude Code & Claude Desktop
- Cursor IDE
- Windsurf
- Antigravity (agy)
"""

import sys
import os
import json
import argparse
from pathlib import Path

def get_base_definitions(projects_dir: Path):
    """Returns the base definitions for all 15 servers, resolving local paths dynamically."""
    
    # 5 Local Workspace MCPs
    local_servers = {
        "skills-library": {
            "type": "stdio",
            "command": "node",
            "args": [str(projects_dir / "skills-library-mcp-public" / "mcp" / "dist" / "index.js")],
            "description": "Searches and installs 1000+ skills and 100+ agents into coding harnesses."
        },
        "toolshed": {
            "type": "stdio",
            "command": "node",
            "args": [str(projects_dir / "toolshed-mcp" / "dist" / "index.js")],
            "description": "Standalone registry and proxy for local agent capabilities across machine corpora."
        },
        "orchestrator": {
            "type": "stdio",
            "command": "node",
            "args": [str(projects_dir / "orchestrator" / "mcp" / "dist" / "index.js")],
            "description": "MCP server over a git repository and local task board for autonomous agent mission planning."
        },
        "verifier": {
            "type": "stdio",
            "command": "node",
            "args": [str(projects_dir / "verifier" / "mcp" / "dist" / "index.js")],
            "description": "MCP server that runs project checks and test suites, durably recording the results."
        },
        "content-creation": {
            "type": "stdio",
            "command": "node",
            "args": [str(projects_dir / "content-creation-mcp" / "mcp" / "dist" / "index.js")],
            "description": "Multimodal creative skills engine (video, 3D, audio, design, text)."
        }
    }

    # 10 Universal / Zero-Config MCPs (runnable anywhere via npx/uvx/python/http)
    universal_servers = {
        "playwright": {
            "type": "stdio",
            "command": "npx",
            "args": ["-y", "@playwright/mcp@latest"],
            "description": "Browser automation and testing via Playwright for visual inspection and navigation."
        },
        "chrome-devtools": {
            "type": "stdio",
            "command": "npx",
            "args": ["-y", "chrome-devtools-mcp@latest"],
            "description": "Chrome/Brave DevTools protocol integration for console logs, network tracing, and DOM inspections."
        },
        "memory": {
            "type": "stdio",
            "command": "npx",
            "args": ["-y", "@modelcontextprotocol/server-memory"],
            "description": "Persistent graph-based memory across sessions with entities, relations, and observations."
        },
        "sequential-thinking": {
            "type": "stdio",
            "command": "npx",
            "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
            "description": "Dynamic step-by-step reasoning tool enabling structured decomposition of complex problems."
        },
        "squish": {
            "type": "stdio",
            "command": "npx",
            "args": ["-y", "squish-memory"],
            "description": "Local-first persistent memory runtime for AI agents with 1-20ms SQLite recall."
        },
        "token-optimizer": {
            "type": "stdio",
            "command": "npx",
            "args": ["-y", "token-optimizer-mcp"],
            "description": "Token optimization for 95%+ context reduction via content deduplication and compression."
        },
        "omega-memory": {
            "type": "stdio",
            "command": "uvx",
            "args": ["omega-memory", "serve"],
            "description": "Persistent agent memory with semantic search, multi-agent coordination, and knowledge graphs."
        },
        "longhand": {
            "type": "stdio",
            "command": "longhand",
            "args": ["mcp-server"],
            "description": "Lossless session history indexer capturing tool calls and thinking blocks."
        },
        "evalview": {
            "type": "stdio",
            "command": "python3",
            "args": ["-m", "evalview", "mcp", "serve"],
            "description": "AI agent regression testing suite detecting regressions in tool calls and output quality."
        },
        "devfleet": {
            "type": "http",
            "url": "http://localhost:18801/mcp",
            "description": "Multi-agent parallel orchestration daemon dispatching parallel agents in isolated worktrees."
        }
    }

    all_servers = {}
    all_servers.update(local_servers)
    all_servers.update(universal_servers)
    return all_servers, local_servers, universal_servers

def format_for_client(client_type: str, servers: dict):
    """Formats the server dictionary to match the target client's expected schema."""
    result = {}
    
    if client_type in ["claude", "cursor", "opencode", "cline", "windsurf"]:
        mcp_servers = {}
        for name, spec in servers.items():
            if spec.get("type") == "http":
                # Stdio-only clients or standard URL
                mcp_servers[name] = {
                    "url": spec["url"],
                    "description": spec.get("description", "")
                }
            else:
                mcp_servers[name] = {
                    "command": spec["command"],
                    "args": spec["args"],
                    "description": spec.get("description", "")
                }
        return {"mcpServers": mcp_servers}
    
    return {"mcpServers": servers}

def main():
    parser = argparse.ArgumentParser(description="Universal MCP Configuration Generator")
    parser.add_argument("--client", choices=["all", "opencode", "cline", "claude", "cursor", "windsurf", "raw"], default="all")
    parser.add_argument("--projects-dir", default=None, help="Root directory where local projects reside")
    parser.add_argument("--output-dir", default=None, help="Directory to save generated JSON files")
    parser.add_argument("--only-universal", action="store_true", help="Exclude local path servers and only output universal packages")
    
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent.parent
    projects_dir = Path(args.projects_dir) if args.projects_dir else repo_root.parent
    output_dir = Path(args.output_dir) if args.output_dir else repo_root / "configs"
    output_dir.mkdir(parents=True, exist_ok=True)

    all_servers, local_servers, universal_servers = get_base_definitions(projects_dir)
    target_servers = universal_servers if args.only_universal else all_servers

    clients = ["opencode", "cline", "claude", "cursor", "windsurf"] if args.client == "all" else [args.client]

    for client in clients:
        formatted = format_for_client(client, target_servers)
        if client == "opencode":
            filename = output_dir / "opencode_mcp.json"
        elif client == "cline":
            filename = output_dir / "cline_mcp_settings.json"
        elif client == "claude":
            filename = output_dir / "claude_desktop.json"
        elif client == "cursor":
            filename = output_dir / "cursor_mcp.json"
        elif client == "windsurf":
            filename = output_dir / "windsurf_mcp.json"
        else:
            filename = output_dir / f"{client}_mcp.json"
            
        with open(filename, "w", encoding="utf-8") as f:
            json.dump(formatted, f, indent=2)
            f.write("\n")
        print(f"Generated: {filename}")

if __name__ == "__main__":
    main()
