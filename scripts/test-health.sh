#!/usr/bin/env bash
# test-health.sh - Verifies prerequisites and local paths for the MCP collection

set -euo pipefail

echo "=========================================="
echo "MCP Collection Dependency Health Check"
echo "=========================================="

check_cmd() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    echo "  [OK] $name: $(command -v "$name")"
  else
    echo "  [MISSING] $name"
  fi
}

check_path() {
  local label="$1"
  local path="$2"
  if [ -e "$path" ]; then
    echo "  [OK] $label: $path"
  else
    echo "  [MISSING] $label: $path"
  fi
}

echo ""
echo "Core Runtimes:"
check_cmd node
check_cmd npm
check_cmd npx
check_cmd python3
check_cmd uv
check_cmd uvx
check_cmd agy

echo ""
echo "Local MCP Server Distributables:"
PROJECTS_DIR="${PROJECTS_DIR:-$HOME/Projects}"
check_path "skills-library" "$PROJECTS_DIR/skills-library-mcp-public/mcp/dist/index.js"
check_path "toolshed" "$PROJECTS_DIR/toolshed-mcp/dist/index.js"
check_path "orchestrator" "$PROJECTS_DIR/orchestrator/mcp/dist/index.js"
check_path "verifier" "$PROJECTS_DIR/verifier/mcp/dist/index.js"
check_path "content-creation" "$PROJECTS_DIR/content-creation-mcp/mcp/dist/index.js"

echo ""
echo "Optional CLI Tools:"
check_cmd longhand
check_cmd devfleet
python3 -c "import evalview" 2>/dev/null && echo "  [OK] python module: evalview" || echo "  [INFO] python module: evalview (can install via pip install evalview)"

echo ""
echo "Check completed."
