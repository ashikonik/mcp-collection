#!/usr/bin/env bash
# clone-local.sh - Clones and builds the 5 local workspace MCP repositories

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLLECTION_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECTS_DIR="${PROJECTS_DIR:-$(cd "$COLLECTION_ROOT/.." && pwd)}"

mkdir -p "$PROJECTS_DIR"

echo "===================================================="
echo " Cloning Local Workspace MCP Repositories"
echo " Destination: $PROJECTS_DIR"
echo "===================================================="

clone_or_update() {
  local name="$1"
  local url="$2"
  local dir_name="$3"
  local target_path="$PROJECTS_DIR/$dir_name"

  if [ -d "$target_path/.git" ]; then
    echo "  ✔ $name is already cloned at: $target_path"
  else
    echo "  --> Cloning $name from $url..."
    git clone "$url" "$target_path"
    echo "  ✔ Cloned $name."
  fi
}

clone_or_update "skills-library" "https://github.com/ashikonik/skills-library-mcp.git" "skills-library-mcp-public"
clone_or_update "toolshed" "https://github.com/ashikonik/toolshed-mcp.git" "toolshed-mcp"
clone_or_update "orchestrator" "https://github.com/ashikonik/orchestrator-mcp.git" "orchestrator"
clone_or_update "verifier" "https://github.com/ashikonik/verifier-mcp.git" "verifier"
clone_or_update "content-creation" "https://github.com/ashikonik/content-creation-mcp.git" "content-creation-mcp"

echo ""
echo "All local workspace MCP repositories are ready in $PROJECTS_DIR!"
