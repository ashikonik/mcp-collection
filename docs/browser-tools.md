# Browser & Automation MCP Servers

This document details the browser automation and developer tools in this collection.

---

## 1. `playwright` (`@playwright/mcp@latest`)
- **Transport**: `stdio` (`npx -y @playwright/mcp@latest`)
- **Capabilities**:
  - Live browser rendering and headless/headful navigation.
  - Page element interaction (`browser_click`, `browser_fill_form`, `browser_type`).
  - High-resolution visual screenshots (`browser_take_screenshot`).
  - Network request inspection and console message capture.

---

## 2. `chrome-devtools` (`chrome-devtools-mcp@latest`)
- **Transport**: `stdio` (`npx -y chrome-devtools-mcp@latest`)
- **Capabilities**:
  - Direct connection to Chromium-based browsers (Chrome, Brave, Edge).
  - DOM tree snapshots and CSS style inspection.
  - Performance trace recordings and Lighthouse audits.
  - Heap snapshots and memory leak diagnostics.
