# Claude Code - Oh My Zsh Plugin
# Aliases and helpers for the Claude Code CLI
# https://github.com/anthropics/claude-code

# -- Prerequisite check --

if ! (( $+commands[claude] )); then
  print "zsh claude-code plugin: claude not found. Install Claude Code: npm install -g @anthropic-ai/claude-code" >&2
  return 1
fi

# -- Configuration variables --

: ${ZSH_CLAUDE_DEFAULT_MODEL:=}
: ${ZSH_CLAUDE_DEFAULT_EFFORT:=}
: ${ZSH_CLAUDE_DEFAULT_PERMISSION_MODE:=}
: ${ZSH_CLAUDE_AUTO_CONTINUE:=false}

# -- Core aliases --

alias cc='claude'
alias ccc='claude --continue'
alias ccr='claude --resume'
alias ccp='claude -p'
alias ccv='claude --version'
alias ccu='claude update'

# -- Session aliases --

alias ccn='claude -n'
alias ccw='claude -w'
alias ccfork='claude --fork-session'

# -- Auth aliases --

alias ccas='claude auth status'
alias ccal='claude auth login'
alias ccao='claude auth logout'

# -- Config aliases --

alias ccmcp='claude mcp'
alias ccag='claude agents'

# -- Model & effort aliases --

function ccm() {
  local model="${1:-${ZSH_CLAUDE_DEFAULT_MODEL}}"
  if [[ -z "$model" ]]; then
    print "Usage: ccm <model>  (opus, sonnet, haiku, or full model ID)" >&2
    return 1
  fi
  shift 2>/dev/null
  claude --model "$model" "$@"
}

function cce() {
  local effort="${1:-${ZSH_CLAUDE_DEFAULT_EFFORT}}"
  if [[ -z "$effort" ]]; then
    print "Usage: cce <effort>  (low, medium, high, max)" >&2
    return 1
  fi
  shift 2>/dev/null
  claude --effort "$effort" "$@"
}

# -- Channel aliases --

alias ccch-tg='claude --channels plugin:telegram@claude-plugins-official'
alias ccch-dc='claude --channels plugin:discord@claude-plugins-official'

function ccch() {
  if [[ -z "$1" ]]; then
    print "Usage: ccch <channel-spec> [claude-args...]" >&2
    print "  e.g. ccch plugin:telegram@claude-plugins-official" >&2
    return 1
  fi
  local channel="$1"
  shift
  claude --channels "$channel" "$@"
}

# -- Helper functions --

# Directory session: create or resume a session named after the current directory
# Similar to tmux's tds alias
function ccds() {
  local dir="${PWD##*/}"
  [[ "$PWD" == "$HOME" ]] && dir="HOME"
  [[ "$PWD" == "/" ]] && dir="ROOT"
  claude --resume "$dir" "$@" 2>/dev/null || claude -n "$dir" "$@"
}

# Resume from a PR number
function ccfp() {
  if [[ -z "$1" ]]; then
    print "Usage: ccfp <pr-number>" >&2
    return 1
  fi
  claude --from-pr "$1"
}

# Pipe content to claude in headless mode
function ccpipe() {
  if [[ -z "$1" ]]; then
    print "Usage: <cmd> | ccpipe \"prompt\"" >&2
    return 1
  fi
  claude -p "$@"
}

# Quick headless query with output
function ccq() {
  if [[ -z "$1" ]]; then
    print "Usage: ccq \"question\"" >&2
    return 1
  fi
  claude -p "$@"
}

# Start claude with default config variables applied
function _claude_with_defaults() {
  local -a args
  args=()

  [[ -n "$ZSH_CLAUDE_DEFAULT_MODEL" ]] && args+=(--model "$ZSH_CLAUDE_DEFAULT_MODEL")
  [[ -n "$ZSH_CLAUDE_DEFAULT_EFFORT" ]] && args+=(--effort "$ZSH_CLAUDE_DEFAULT_EFFORT")
  [[ -n "$ZSH_CLAUDE_DEFAULT_PERMISSION_MODE" ]] && args+=(--permission-mode "$ZSH_CLAUDE_DEFAULT_PERMISSION_MODE")

  claude "${args[@]}" "$@"
}

# -- Tab completion --

function _claude_code_models() {
  local -a models
  models=(
    'opus:Claude Opus (most capable)'
    'sonnet:Claude Sonnet (balanced)'
    'haiku:Claude Haiku (fastest)'
  )
  _describe 'model' models
}

function _claude_code_efforts() {
  local -a efforts
  efforts=(
    'low:Minimal reasoning'
    'medium:Balanced reasoning'
    'high:Deep reasoning'
    'max:Maximum reasoning depth'
  )
  _describe 'effort' efforts
}

function _claude_code_permission_modes() {
  local -a modes
  modes=(
    'plan:Plan mode - confirm before actions'
    'auto:Auto mode - approve safe actions'
    'manual:Manual mode - approve everything'
  )
  _describe 'permission-mode' modes
}

function _ccm() {
  _arguments '1:model:_claude_code_models' '*::args:'
}

function _cce() {
  _arguments '1:effort:_claude_code_efforts' '*::args:'
}

compdef _ccm ccm
compdef _cce cce

# -- Auto-continue on shell start --

if [[ "$ZSH_CLAUDE_AUTO_CONTINUE" == "true" && -z "$CLAUDECODE" ]]; then
  claude --continue 2>/dev/null
fi
