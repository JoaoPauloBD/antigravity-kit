#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Claude Cook skill..."

# Check if required directories exist
if [[ ! -d "$SCRIPT_DIR/commands" ]] || [[ ! -d "$SCRIPT_DIR/agents" ]]; then
    echo "Error: Required directories not found in $SCRIPT_DIR"
    echo "Make sure you're running this from the claude-cook skill directory."
    exit 1
fi

# Create target directories
echo "Creating directories..."
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/skills/cook
mkdir -p ~/.claude/templates
mkdir -p ~/.claude/agents

# Copy commands
echo "Copying commands..."
cp -f "$SCRIPT_DIR/commands/"*.md ~/.claude/commands/

# Copy agents (chefs)
echo "Copying agents (chefs)..."
cp -f "$SCRIPT_DIR/agents/"*.md ~/.claude/agents/

# Copy templates
echo "Copying templates..."
cp -f "$SCRIPT_DIR/templates/"*.md ~/.claude/templates/

# Copy main skill file
echo "Copying skill definition..."
cp -f "$SCRIPT_DIR/SKILL.md" ~/.claude/skills/cook/

echo ""
echo "Claude Cook installed successfully!"
echo ""
echo "Installed components:"
echo "  Commands:"
for f in "$SCRIPT_DIR/commands/"*.md; do
    echo "    ~/.claude/commands/$(basename "$f")"
done
echo ""
echo "  Agents (Chefs):"
for f in "$SCRIPT_DIR/agents/"*.md; do
    echo "    ~/.claude/agents/$(basename "$f")"
done
echo ""
echo "  Templates:"
for f in "$SCRIPT_DIR/templates/"*.md; do
    echo "    ~/.claude/templates/$(basename "$f")"
done
echo ""
echo "  Skill:"
echo "    ~/.claude/skills/cook/SKILL.md"
echo ""
echo "Now open Claude Code and run:"
echo "  /cook <your feature description>"
echo ""
echo "Examples:"
echo "  /cook Add user authentication"
echo "  /cook Fix login bug --microwave"
echo "  /cook --dry-run Add payment processing"
