# claude-code

Oh My Zsh plugin for [Claude Code](https://github.com/anthropics/claude-code) — aliases, helpers, and tab completion for the Claude Code CLI.

## Installation

### Oh My Zsh (custom plugin)

```bash
git clone https://github.com/mausv/ohmyzsh-claude-code ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/claude-code
```

Then add `claude-code` to your plugins in `~/.zshrc`:

```zsh
plugins=(... claude-code)
```

### Manual

Copy `claude-code.plugin.zsh` to your custom plugins directory:

```bash
mkdir -p ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/claude-code
cp claude-code.plugin.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/claude-code/
```

## Aliases

### Core

| Alias | Command | Description |
|-------|---------|-------------|
| `cc` | `claude` | Start interactive session |
| `ccc` | `claude --continue` | Continue last conversation |
| `ccr` | `claude --resume` | Open session picker |
| `ccp` | `claude -p` | Headless/print mode |
| `ccv` | `claude --version` | Show version |
| `ccu` | `claude update` | Update Claude Code |

### Sessions

| Alias | Command | Description |
|-------|---------|-------------|
| `ccn` | `claude -n` | Start a named session |
| `ccw` | `claude -w` | Start in a git worktree |
| `ccfork` | `claude --fork-session` | Fork current session |

### Auth

| Alias | Command | Description |
|-------|---------|-------------|
| `ccas` | `claude auth status` | Check auth status |
| `ccal` | `claude auth login` | Sign in |
| `ccao` | `claude auth logout` | Sign out |

### Config

| Alias | Command | Description |
|-------|---------|-------------|
| `ccmcp` | `claude mcp` | Manage MCP servers |
| `ccag` | `claude agents` | List configured agents |

### Channels

| Alias | Command | Description |
|-------|---------|-------------|
| `ccch-tg` | `claude --channels plugin:telegram@...` | Start with Telegram channel |
| `ccch-dc` | `claude --channels plugin:discord@...` | Start with Discord channel |
| `ccch <spec>` | `claude --channels <spec>` | Start with custom channel |

## Functions

| Function | Description | Example |
|----------|-------------|---------|
| `ccm <model>` | Start with a specific model | `ccm opus` |
| `cce <effort>` | Start with a specific effort level | `cce high` |
| `ccds` | Directory session — create/resume a session named after `$PWD` | `cd my-project && ccds` |
| `ccfp <pr>` | Resume sessions linked to a GitHub PR | `ccfp 123` |
| `ccpipe "prompt"` | Pipe stdin to Claude in headless mode | `cat log.txt \| ccpipe "analyze errors"` |
| `ccq "question"` | Quick headless query | `ccq "what does this error mean?"` |

## Configuration Variables

Set these in your `~/.zshrc` before the plugins line:

| Variable | Default | Description |
|----------|---------|-------------|
| `ZSH_CLAUDE_DEFAULT_MODEL` | (unset) | Default model for `ccm` and `_claude_with_defaults` |
| `ZSH_CLAUDE_DEFAULT_EFFORT` | (unset) | Default effort level |
| `ZSH_CLAUDE_DEFAULT_PERMISSION_MODE` | (unset) | Default permission mode (plan/auto/manual) |
| `ZSH_CLAUDE_AUTO_CONTINUE` | `false` | Auto-continue last session when opening a new shell |

### Example configuration

```zsh
# ~/.zshrc
ZSH_CLAUDE_DEFAULT_MODEL="sonnet"
ZSH_CLAUDE_DEFAULT_EFFORT="high"
ZSH_CLAUDE_AUTO_CONTINUE=false

plugins=(... claude-code)
```

## Tab Completion

- `ccm [TAB]` — completes model names (opus, sonnet, haiku, full IDs)
- `cce [TAB]` — completes effort levels (low, medium, high, max)

## Requirements

- [Claude Code](https://github.com/anthropics/claude-code) CLI installed (`npm install -g @anthropic-ai/claude-code`)
- [Oh My Zsh](https://ohmyz.sh/) (or compatible zsh plugin manager)
