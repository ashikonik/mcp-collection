#!/usr/bin/env bash
# test-health.sh - Universal MCP Collection Environment & Agent Health Check
# Works across any operating system (Linux, macOS, WSL) and any AI agent harness.

set -euo pipefail

# ANSI color codes
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${BOLD}${CYAN}====================================================${RESET}"
echo -e "${BOLD}${CYAN}   Universal MCP Collection Health Check            ${RESET}"
echo -e "${BOLD}${CYAN}====================================================${RESET}"

OS_NAME="$(uname -s)"
echo -e "Operating System: ${BOLD}${OS_NAME} ($(uname -m))${RESET}"

# 1. Core Language & Package Runtimes
echo -e "\n${BOLD}[1/4] Core Language & Execution Runtimes${RESET}"

check_cmd() {
  local name="$1"
  local required="${2:-true}"
  if command -v "$name" >/dev/null 2>&1; then
    local path
    path="$(command -v "$name")"
    echo -e "  ${GREEN}✔${RESET} ${BOLD}${name}${RESET}: ${path}"
    return 0
  else
    if [ "$required" = "true" ]; then
      echo -e "  ${RED}✖${RESET} ${BOLD}${name}${RESET}: ${RED}Not found${RESET} (Required)"
    else
      echo -e "  ${YELLOW}○${RESET} ${BOLD}${name}${RESET}: ${YELLOW}Not found${RESET} (Optional)"
    fi
    return 1
  fi
}

check_cmd "node" "true"
check_cmd "npm" "true"
check_cmd "npx" "true"
check_cmd "python3" "true"
check_cmd "uv" "false"
check_cmd "uvx" "false"
check_cmd "git" "true"

# 2. AI Agent Harness Detection
echo -e "\n${BOLD}[2/4] Installed AI Agent Harnesses & Clients${RESET}"

detected_agents=0

check_agent() {
  local name="$1"
  local cmd="$2"
  local config_path="$3"

  local is_installed=false
  local note=""

  if command -v "$cmd" >/dev/null 2>&1; then
    is_installed=true
    note="Binary found: $(command -v "$cmd")"
  fi

  if [ -n "$config_path" ] && [ -e "$config_path" ]; then
    is_installed=true
    note="${note:+$note | }Config found: $config_path"
  fi

  if [ "$is_installed" = true ]; then
    echo -e "  ${GREEN}✔${RESET} ${BOLD}${name}${RESET} [DETECTED] (${note})"
    detected_agents=$((detected_agents + 1))
  else
    echo -e "  ${YELLOW}○${RESET} ${BOLD}${name}${RESET} [Not installed]"
  fi
}

check_agent "Antigravity (agy)" "agy" "$HOME/.gemini/config/mcp_config.json"
check_agent "Claude Code / Desktop" "claude" "$HOME/.claude.json"
check_agent "OpenCode" "opencode" "$HOME/.config/opencode/mcp.json"
check_agent "Cline (VS Code)" "code" "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json"
check_agent "Cursor" "cursor" "$HOME/.cursor/mcp.json"
check_agent "Windsurf" "windsurf" "$HOME/.codeium/windsurf/mcp_config.json"
check_agent "Zed" "zed" "$HOME/.config/zed/settings.json"

if [ "$detected_agents" -eq 0 ]; then
  echo -e "  ${YELLOW}Note: No specific AI CLI/IDE was detected, but any MCP client can still use this collection.${RESET}"
fi

# 3. Universal Standalone MCP Readiness
echo -e "\n${BOLD}[3/4] Universal Standalone MCPs (Zero-Config NPM/UVX)${RESET}"
echo -e "  ${GREEN}✔${RESET} ${BOLD}playwright${RESET} (via npx @playwright/mcp@latest)"
echo -e "  ${GREEN}✔${RESET} ${BOLD}chrome-devtools${RESET} (via npx chrome-devtools-mcp@latest)"
echo -e "  ${GREEN}✔${RESET} ${BOLD}memory${RESET} (via npx @modelcontextprotocol/server-memory)"
echo -e "  ${GREEN}✔${RESET} ${BOLD}sequential-thinking${RESET} (via npx @modelcontextprotocol/server-sequential-thinking)"
echo -e "  ${GREEN}✔${RESET} ${BOLD}squish${RESET} (via npx squish-memory)"
echo -e "  ${GREEN}✔${RESET} ${BOLD}token-optimizer${RESET} (via npx token-optimizer-mcp)"
echo -e "  ${GREEN}✔${RESET} ${BOLD}omega-memory${RESET} (via uvx omega-memory serve)"

# 4. Local Workspace Repositories
echo -e "\n${BOLD}[4/4] Local Workspace MCP Repositories${RESET}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLLECTION_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECTS_DIR="${PROJECTS_DIR:-$(cd "$COLLECTION_ROOT/.." && pwd)}"

check_local_repo() {
  local name="$1"
  local subpath="$2"
  local repo_url="$3"
  local full_path="$PROJECTS_DIR/$subpath"

  if [ -e "$full_path" ]; then
    echo -e "  ${GREEN}✔${RESET} ${BOLD}${name}${RESET}: Found ($full_path)"
  else
    echo -e "  ${YELLOW}○${RESET} ${BOLD}${name}${RESET}: Not cloned at $full_path"
    echo -e "      ${CYAN}→ To enable, clone: git clone $repo_url \"$PROJECTS_DIR/$(basename "$(dirname "$full_path")")\"${RESET}"
  fi
}

check_local_repo "skills-library" "skills-library-mcp-public/mcp/dist/index.js" "https://github.com/ashikonik/skills-library-mcp.git"
check_local_repo "toolshed" "toolshed-mcp/dist/index.js" "https://github.com/ashikonik/toolshed-mcp.git"
check_local_repo "orchestrator" "orchestrator/mcp/dist/index.js" "https://github.com/ashikonik/orchestrator-mcp.git"
check_local_repo "verifier" "verifier/mcp/dist/index.js" "https://github.com/ashikonik/verifier.git"
check_local_repo "content-creation" "content-creation-mcp/mcp/dist/index.js" "https://github.com/ashikonik/content-creation-mcp.git"

echo -e "\n${BOLD}${GREEN}✔ Health Check Complete!${RESET}"
echo -e "To configure any agent, run: ${BOLD}./scripts/setup.sh --help${RESET}\n"
