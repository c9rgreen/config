#!/usr/bin/env bash
#
# Set up bugwarrior to sync GitLab issues/MRs/todos into taskwarrior.
#
# Idempotent: safe to re-run. It installs the bugwarrior CLI, (re)generates the
# taskwarrior UDA definitions, and links + loads the launchd agent that pulls every
# 30 minutes. The declarative config (bugwarriorrc, taskrc.bugwarrior, the fish
# wrapper, the plist) is version-controlled in this repo; this script performs the
# imperative, machine-local steps that can't be committed.
#
# Prerequisites:
#   - uv          (https://docs.astral.sh/uv/) — installs the bugwarrior CLI
#   - fish        — the launchd job runs `fish -l -c 'bugwarrior pull'`
#   - GITLAB_TOKEN exported in fish/conf.d/private.fish (gitignored)

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BW_DIR="$CONFIG_DIR/bugwarrior"
TASK_DIR="$CONFIG_DIR/task"
BW_TASKRC="$TASK_DIR/taskrc.bugwarrior"
UDA_FILE="$TASK_DIR/bugwarrior-udas.rc"
LABEL="com.cgreen.bugwarrior-pull"
PLIST_SRC="$BW_DIR/$LABEL.plist"
PLIST_DEST="$HOME/Library/LaunchAgents/$LABEL.plist"

# uv installs tool executables here by default.
export PATH="$HOME/.local/bin:$PATH"

log()  { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$1" >&2; }
die()  { printf '\033[1;31merror:\033[0m %s\n' "$1" >&2; exit 1; }

# --- 1. Install the bugwarrior CLI ------------------------------------------------
command -v uv >/dev/null 2>&1 || die "uv not found — install it first: https://docs.astral.sh/uv/"

if bugwarrior --version >/dev/null 2>&1; then
    log "bugwarrior already installed: $(bugwarrior --version)"
else
    # Pin Python 3.11: bugwarrior's taskw dependency still imports distutils, which was
    # removed from the stdlib in 3.12. --reinstall rebuilds a broken (wrong-Python) env.
    log "Installing bugwarrior (Python 3.11 — taskw still imports distutils)"
    uv tool install --python 3.11 --reinstall bugwarrior
fi

# --- 2. (Re)generate taskwarrior UDA definitions ----------------------------------
[ -f "$BW_TASKRC" ] || die "missing $BW_TASKRC — is this the config repo?"
log "Generating taskwarrior UDA definitions -> $UDA_FILE"
TASKRC="$BW_TASKRC" bugwarrior uda > "$UDA_FILE" \
    || die "bugwarrior uda failed — check $BW_DIR/bugwarriorrc"

# --- 3. Link + load the launchd agent ---------------------------------------------
[ -f "$PLIST_SRC" ] || die "missing $PLIST_SRC"

# The plist runs fish as a login shell so the agent inherits GITLAB_TOKEN (from
# private.fish) and the autoloaded `bugwarrior` wrapper. Verify that fish exists.
FISH_BIN="$(/usr/bin/awk -F'[<>]' '/<string>.*fish<\/string>/{print $3; exit}' "$PLIST_SRC")"
if [ -n "$FISH_BIN" ] && [ ! -x "$FISH_BIN" ]; then
    warn "$FISH_BIN (referenced in the plist) is not executable — update ProgramArguments to your fish path."
fi

log "Linking launchd agent -> $PLIST_DEST"
mkdir -p "$HOME/Library/LaunchAgents"
ln -sf "$PLIST_SRC" "$PLIST_DEST"

DOMAIN="gui/$(id -u)"
log "(Re)loading launchd agent $LABEL"
launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true
launchctl bootstrap "$DOMAIN" "$PLIST_DEST"

# --- 4. Sanity-check the token ----------------------------------------------------
if command -v fish >/dev/null 2>&1; then
    if ! fish -l -c 'test -n "$GITLAB_TOKEN"' >/dev/null 2>&1; then
        warn "GITLAB_TOKEN is not set in your fish environment (fish/conf.d/private.fish)."
        warn "The pull will fail to authenticate until you set it."
    fi
else
    warn "fish not found on PATH — the launchd job needs it to run."
fi

log "Done. RunAtLoad triggered an initial pull; it then runs every 30 min."
log "Logs:  ~/Library/Logs/bugwarrior-pull.log"
log "Check: launchctl print $DOMAIN/$LABEL"
log "Tasks: task gitlabnumber.any: list"
