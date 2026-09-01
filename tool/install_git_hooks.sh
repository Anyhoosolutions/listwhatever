#!/usr/bin/env bash
set -e

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not inside a git repo. Run: git init"
  exit 1
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
HOOK_SRC="$REPO_ROOT/tool/hooks/pre-commit"
HOOK_DST="$(git rev-parse --git-path hooks/pre-commit)"

mkdir -p "$REPO_ROOT/tool/hooks"
chmod +x "$HOOK_SRC"

if [ -L "$HOOK_DST" ] && [ "$(readlink "$HOOK_DST")" = "$HOOK_SRC" ]; then
  echo "Hook already installed: $HOOK_DST -> $HOOK_SRC"
  exit 0
fi

if [ -e "$HOOK_DST" ] || [ -L "$HOOK_DST" ]; then
  backup="$HOOK_DST.bak.$(date +%Y%m%d-%H%M%S)"
  mv "$HOOK_DST" "$backup"
  echo "Backed up existing hook to: $backup"
fi

mkdir -p "$(dirname "$HOOK_DST")"
ln -s "$HOOK_SRC" "$HOOK_DST"
echo "Installed: $HOOK_DST -> $HOOK_SRC"
echo "Tracked source: tool/hooks/pre-commit. Edit there; symlink picks up changes."
