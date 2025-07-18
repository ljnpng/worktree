# Git Worktree Plugin

A Zsh plugin that simplifies Git worktree management with convenient commands and shell integration.

## Installation

### Oh My Zsh

1. Clone this repository to your Oh My Zsh custom plugins directory:
```bash
git clone https://github.com/ljnpng/worktree-plugin.git ~/.oh-my-zsh/custom/plugins/worktree
```

2. Add `worktree` to your plugins list in `~/.zshrc`:
```bash
plugins=(... worktree)
```

3. Restart your shell or run:
```bash
source ~/.zshrc
```

### Manual Installation

1. Download `worktree.plugin.zsh` and source it in your `~/.zshrc`:
```bash
source /path/to/worktree.plugin.zsh
```

## Usage

### Create/Switch to Worktree

```bash
worktree <branch-name>
```

Creates a worktree in `../repo-name-worktree/branch-name` and switches to it.

**Examples:**
```bash
# Create worktree for existing branch
worktree feature-login

# Create worktree for new branch
worktree new-feature
```

### Remove Worktree

```bash
worktree-remove <branch-name>
```

Removes the worktree for the specified branch.

**Example:**
```bash
worktree-remove feature-login
```

### List Branches

```bash
origin_branch
```

Lists all branches sorted by commit date.

### Navigate to Git Root

```bash
git_root
```

Navigates to the Git repository root directory.

## Configuration

Customize behavior with environment variables:

```bash
# IDE command for opening worktrees
export WORKTREE_CODE_EDITOR="code"

# Command executed after switching to worktree
export WORKTREE_POST_SWITCH="echo 'Switched to worktree'"

# Command executed after creating worktree
export WORKTREE_POST_CREATE="npm install"

# Directory pattern for project discovery
export WORKTREE_CODE_DIR="../*"
```

## Features

- **Smart Directory Structure**: Organizes worktrees in `../repo-name-worktree/` directory
- **Tab Completion**: Auto-complete branch names and worktree paths
- **IDE Integration**: Optional IDE opening after worktree creation
- **Post-Action Hooks**: Customizable commands after create/switch operations
- **Command Preview**: Shows the actual Git commands before execution
- **Interactive Prompts**: Confirmation dialogs for IDE opening

## Tab Completion

The plugin provides tab completion for:
- `worktree <Tab>` - Complete existing branches and worktree names
- `worktree-remove <Tab>` - Complete existing branch names

## Dependencies

- Git (relatively modern version)
- Zsh shell
- Oh My Zsh (for Oh My Zsh installation method)

## License

MIT License

