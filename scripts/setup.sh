#!/usr/bin/env bash
# setup.sh - Universal MCP Setup & Auto-Configuration Script
# Configures MCP servers for any agent: OpenCode, Cline, Claude Code, Cursor, Windsurf, agy.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLLECTION_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECTS_DIR="${PROJECTS_DIR:-$(cd "$COLLECTION_ROOT/.." && pwd)}"

TARGET="all"
ONLY_UNIVERSAL=false

print_usage() {
  cat <<EOF
Usage: ./scripts/setup.sh [OPTIONS]

Options:
  -t, --target <agent>    Target agent to configure:
                          all        - Auto-configure all detected agents (default)
                          opencode   - OpenCode (~/.config/opencode/mcp.json)
                          cline      - Cline / Roo Code in VS Code / VSCodium
                          claude     - Claude Code & Claude Desktop
                          cursor     - Cursor IDE (~/.cursor/mcp.json)
                          windsurf   - Windsurf IDE (~/.codeium/windsurf/mcp_config.json)
                          agy        - Google Antigravity CLI
  -u, --only-universal    Only configure the 10 standalone npm/uvx packages (skips local repos)
  -p, --projects-dir <dir> Path to local workspace repos (default: $PROJECTS_DIR)
  -h, --help              Show this help message

Examples:
  ./scripts/setup.sh --target opencode
  ./scripts/setup.sh --target cline
  ./scripts/setup.sh --target all
EOF
}

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    -t|--target)
      TARGET="$2"
      shift 2
      ;;
    -u|--only-universal)
      ONLY_UNIVERSAL=true
      shift
      ;;
    -p|--projects-dir)
      PROJECTS_DIR="$2"
      shift 2
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      print_usage
      exit 1
      ;;
  esac
done

echo "===================================================="
echo " Universal MCP Setup (Target: $TARGET)"
echo " Projects Root: $PROJECTS_DIR"
echo "===================================================="

# Generate fresh config JSONs
GEN_ARGS=(--projects-dir "$PROJECTS_DIR")
if [ "$ONLY_UNIVERSAL" = true ]; then
  GEN_ARGS+=(--only-universal)
fi
python3 "$SCRIPT_DIR/generate-configs.py" "${GEN_ARGS[@]}" >/dev/null

CONFIGS_DIR="$COLLECTION_ROOT/configs"

merge_json_config() {
  local target_file="$1"
  local source_file="$2"
  local label="$3"

  local target_dir
  target_dir="$(dirname "$target_file")"
  mkdir -p "$target_dir"

  if [ -f "$target_file" ]; then
    cp "$target_file" "${target_file}.bak"
    echo "  [BACKUP] Saved existing config to ${target_file}.bak"
  fi

  python3 -c "
import json, sys
source_data = json.load(open('$source_file'))
target_file = '$target_file'
try:
    with open(target_file, 'r') as f:
        existing = json.load(f)
except Exception:
    existing = {}

if 'mcpServers' not in existing:
    existing['mcpServers'] = {}

existing['mcpServers'].update(source_data.get('mcpServers', {}))
with open(target_file, 'w') as f:
    json.dump(existing, f, indent=2)
    f.write('\n')
"
  echo "  ✔ Configured $label: $target_file"
}

# 1. OpenCode
configure_opencode() {
  echo -e "\n--> Configuring OpenCode..."
  local opencode_config="$HOME/.config/opencode/mcp.json"
  merge_json_config "$opencode_config" "$CONFIGS_DIR/opencode_mcp.json" "OpenCode"
  # Also write to local workspace if inside an OpenCode project
  if [ -d "$PROJECTS_DIR/.opencode" ]; then
    merge_json_config "$PROJECTS_DIR/.opencode/mcp.json" "$CONFIGS_DIR/opencode_mcp.json" "OpenCode Workspace"
  fi
}

# 2. Cline / Roo Code
configure_cline() {
  echo -e "\n--> Configuring Cline / Roo Code..."
  local configured=false

  # Standard VS Code Cline path
  local cline_path="$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json"
  merge_json_config "$cline_path" "$CONFIGS_DIR/cline_mcp_settings.json" "Cline (VS Code)"
  configured=true

  # Roo Code path
  local roo_path="$HOME/.config/Code/User/globalStorage/rooveterinaryinc.roo-cline/settings/cline_mcp_settings.json"
  if [ -d "$(dirname "$roo_path")" ]; then
    merge_json_config "$roo_path" "$CONFIGS_DIR/cline_mcp_settings.json" "Roo Code"
  fi

  # VSCodium path
  local codium_cline="$HOME/.config/VSCodium/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json"
  if [ -d "$(dirname "$codium_cline")" ]; then
    merge_json_config "$codium_cline" "$CONFIGS_DIR/cline_mcp_settings.json" "Cline (VSCodium)"
  fi
}

# 3. Claude Code & Claude Desktop
configure_claude() {
  echo -e "\n--> Configuring Claude..."
  # Claude Code (~/.claude.json)
  merge_json_config "$HOME/.claude.json" "$CONFIGS_DIR/claude_desktop.json" "Claude Code"

  # Claude Desktop
  local claude_desktop=""
  if [[ "$OSTYPE" == "darwin"* ]]; then
    claude_desktop="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
  else
    claude_desktop="$HOME/.config/Claude/claude_desktop_config.json"
  fi
  merge_json_config "$claude_desktop" "$CONFIGS_DIR/claude_desktop.json" "Claude Desktop"
}

# 4. Cursor IDE
configure_cursor() {
  echo -e "\n--> Configuring Cursor IDE..."
  local cursor_config="$HOME/.cursor/mcp.json"
  merge_json_config "$cursor_config" "$CONFIGS_DIR/cursor_mcp.json" "Cursor"
}

# 5. Windsurf
configure_windsurf() {
  echo -e "\n--> Configuring Windsurf..."
  local windsurf_config="$HOME/.codeium/windsurf/mcp_config.json"
  merge_json_config "$windsurf_config" "$CONFIGS_DIR/windsurf_mcp.json" "Windsurf"
}

# 6. Antigravity (agy)
configure_agy() {
  echo -e "\n--> Configuring Antigravity (agy)..."
  if command -v agy >/dev/null 2>&1; then
    bash "$SCRIPT_DIR/setup-agy.sh"
  else
    echo "  ○ 'agy' command not found. Skipping agy CLI registration."
  fi
}

case "$TARGET" in
  opencode)
    configure_opencode
    ;;
  cline)
    configure_cline
    ;;
  claude)
    configure_claude
    ;;
  cursor)
    configure_cursor
    ;;
  windsurf)
    configure_windsurf
    ;;
  agy)
    configure_agy
    ;;
  all)
    configure_opencode
    configure_cline
    configure_claude
    configure_cursor
    configure_windsurf
    configure_agy
    ;;
  *)
    echo "Unknown target: $TARGET" >&2
    exit 1
    ;;
esac

echo -e "\n===================================================="
echo " Setup complete! Configured for target: $TARGET"
echo " Configuration files are located in: $CONFIGS_DIR"
echo "===================================================="
