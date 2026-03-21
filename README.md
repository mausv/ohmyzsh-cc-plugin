# claude-code

Oh My Zsh plugin for [Claude Code](https://github.com/anthropics/claude-code) — aliases, helpers, and tab completion for the Claude Code CLI.

## Installation

### Oh My Zsh (custom plugin)

```bash
git clone https://github.com/mausv/ohmyzsh-cc-plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/claude-code
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
| `cl` | `claude` | Start interactive session |
| `clc` | `claude --continue` | Continue last conversation |
| `clr` | `claude --resume` | Open session picker |
| `clp` | `claude -p` | Headless/print mode |
| `clv` | `claude --version` | Show version |
| `clu` | `claude update` | Update Claude Code |

### Sessions

| Alias | Command | Description |
|-------|---------|-------------|
| `cln` | `claude -n` | Start a named session |
| `clw` | `claude -w` | Start in a git worktree |
| `clfork` | `claude --fork-session` | Fork current session |

### Auth

| Alias | Command | Description |
|-------|---------|-------------|
| `clas` | `claude auth status` | Check auth status |
| `clal` | `claude auth login` | Sign in |
| `clao` | `claude auth logout` | Sign out |

### Config

| Alias | Command | Description |
|-------|---------|-------------|
| `clmcp` | `claude mcp` | Manage MCP servers |
| `clag` | `claude agents` | List configured agents |

### Channels

| Alias | Command | Description |
|-------|---------|-------------|
| `clch-tg` | `claude --channels plugin:telegram@...` | Start with Telegram channel |
| `clch-dc` | `claude --channels plugin:discord@...` | Start with Discord channel |
| `clch <spec>` | `claude --channels <spec>` | Start with custom channel |

## Functions

| Function | Description | Example |
|----------|-------------|---------|
| `clm <model>` | Start with a specific model | `clm opus` |
| `cle <effort>` | Start with a specific effort level | `cle high` |
| `clds` | Directory session — create/resume a session named after `$PWD` | `cd my-project && clds` |
| `clfp <pr>` | Resume sessions linked to a GitHub PR | `clfp 123` |
| `clpipe "prompt"` | Pipe stdin to Claude in headless mode | `cat log.txt \| clpipe "analyze errors"` |
| `clq "question"` | Quick headless query | `clq "what does this error mean?"` |

## Configuration Variables

Set these in your `~/.zshrc` before the plugins line:

| Variable | Default | Description |
|----------|---------|-------------|
| `ZSH_CLAUDE_DEFAULT_MODEL` | (unset) | Default model for `clm` and `_claude_with_defaults` |
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

- `clm [TAB]` — completes model names (opus, sonnet, haiku)
- `cle [TAB]` — completes effort levels (low, medium, high, max)

## Requirements

- [Claude Code](https://github.com/anthropics/claude-code) CLI installed (`npm install -g @anthropic-ai/claude-code`)
- [Oh My Zsh](https://ohmyz.sh/) (or compatible zsh plugin manager)
