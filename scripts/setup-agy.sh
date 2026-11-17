#!/usr/bin/env bash
# setup-agy.sh - Configures all collection MCP servers into Antigravity (agy)

set -euo pipefail

echo "=========================================="
echo "Configuring MCP Servers for Antigravity"
echo "=========================================="

command -v agy >/dev/null 2>&1 || {
  echo "Error: 'agy' command not found. Ensure Antigravity CLI is installed." >&2
  exit 1
}

PROJECTS_DIR="${PROJECTS_DIR:-$HOME/Projects}"

echo "[1/15] Registering skills-library..."
agy mcp add skills-library node "$PROJECTS_DIR/skills-library-mcp-public/mcp/dist/index.js"

echo "[2/15] Registering toolshed..."
agy mcp add toolshed node "$PROJECTS_DIR/toolshed-mcp/dist/index.js"

echo "[3/15] Registering orchestrator..."
agy mcp add orchestrator node "$PROJECTS_DIR/orchestrator/mcp/dist/index.js"

echo "[4/15] Registering verifier..."
agy mcp add verifier node "$PROJECTS_DIR/verifier/mcp/dist/index.js"

echo "[5/15] Registering content-creation..."
agy mcp add content-creation node "$PROJECTS_DIR/content-creation-mcp/mcp/dist/index.js"

echo "[6/15] Registering playwright..."
agy mcp add playwright -- npx -y @playwright/mcp@latest

echo "[7/15] Registering chrome-devtools..."
agy mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest

echo "[8/15] Registering memory..."
agy mcp add memory -- npx -y @modelcontextprotocol/server-memory

echo "[9/15] Registering sequential-thinking..."
agy mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking

echo "[10/15] Registering squish..."
agy mcp add squish -- npx -y squish-memory

echo "[11/15] Registering token-optimizer..."
agy mcp add token-optimizer -- npx -y token-optimizer-mcp

echo "[12/15] Registering omega-memory..."
agy mcp add omega-memory uvx omega-memory serve

echo "[13/15] Registering longhand..."
agy mcp add longhand longhand mcp-server

echo "[14/15] Registering evalview..."
agy mcp add evalview python3 -m evalview mcp serve

echo "[15/15] Registering devfleet..."
agy mcp add devfleet http://localhost:18801/mcp

echo ""
echo "All MCP servers registered successfully in agy!"
echo "Current status:"
agy mcp list
