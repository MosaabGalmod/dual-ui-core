#!/usr/bin/env bash
# Dual-UI Core Universal Installer (Bash for macOS / Linux)
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/install.sh | bash
# or run locally:
#   ./install.sh [all|antigravity|claude|cursor|windsurf|cline|project]

set -e

TARGET="${1:-all}"
BASE_URL="https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main"
LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || true)"

echo "=========================================================="
echo "  Dual-UI Core: Bilingual & Dual-Theme Agent Skill Setup"
echo "=========================================================="

fetch_content() {
    local file="$1"
    if [ -n "$LOCAL_DIR" ] && [ -f "$LOCAL_DIR/$file" ]; then
        cat "$LOCAL_DIR/$file"
    else
        curl -fsSL "$BASE_URL/$file"
    fi
}

# 1. Antigravity & Gemini CLI
if [ "$TARGET" = "all" ] || [ "$TARGET" = "antigravity" ] || [ "$TARGET" = "gemini" ]; then
    AGY_DIR="$HOME/.gemini/config/skills/dual-ui-core"
    mkdir -p "$AGY_DIR"
    fetch_content "SKILL.md" > "$AGY_DIR/SKILL.md"
    echo "[OK] Installed to Antigravity / Gemini CLI: $AGY_DIR/SKILL.md"
fi

# 2. Claude Code
if [ "$TARGET" = "all" ] || [ "$TARGET" = "claude" ]; then
    CLAUDE_DIR="$HOME/.claude/skills/dual-ui-core"
    mkdir -p "$CLAUDE_DIR"
    fetch_content "SKILL.md" > "$CLAUDE_DIR/SKILL.md"
    echo "[OK] Installed to Claude Code Skill: $CLAUDE_DIR/SKILL.md"

    if [ -d "$HOME/.claude" ]; then
        CLAUDE_GLOBAL="$HOME/.claude/CLAUDE.md"
        if [ -f "$CLAUDE_GLOBAL" ]; then
            if ! grep -q "Dual-UI Core" "$CLAUDE_GLOBAL"; then
                echo -e "\n\n" >> "$CLAUDE_GLOBAL"
                fetch_content "DESIGN_RULES.md" >> "$CLAUDE_GLOBAL"
                echo "[OK] Appended rules to global Claude instructions: $CLAUDE_GLOBAL"
            fi
        fi
    fi
fi

# 3. Project-level setup
if [ "$TARGET" = "all" ] || [ "$TARGET" = "project" ] || [ "$TARGET" = "cursor" ]; then
    fetch_content "adapters/.cursorrules" > ".cursorrules"
    echo "[OK] Generated .cursorrules in current directory"
fi

if [ "$TARGET" = "all" ] || [ "$TARGET" = "project" ] || [ "$TARGET" = "windsurf" ]; then
    fetch_content "adapters/.windsurfrules" > ".windsurfrules"
    echo "[OK] Generated .windsurfrules in current directory"
fi

if [ "$TARGET" = "all" ] || [ "$TARGET" = "project" ] || [ "$TARGET" = "cline" ]; then
    fetch_content "adapters/.clinerules" > ".clinerules"
    echo "[OK] Generated .clinerules in current directory"
fi

if [ "$TARGET" = "all" ] || [ "$TARGET" = "project" ]; then
    fetch_content "AGENTS.md" > "AGENTS.md"
    echo "[OK] Generated AGENTS.md in current directory"
    fetch_content "DESIGN_RULES.md" > "DESIGN_RULES.md"
    echo "[OK] Generated DESIGN_RULES.md in current directory"
fi

echo -e "\nDual-UI Core installation completed successfully!"
