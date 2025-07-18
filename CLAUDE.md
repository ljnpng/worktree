# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Zsh plugin for working with Git worktrees. It provides convenient commands and shell functions to manage Git worktrees with improved workflow and IDE integration.

## Architecture

The plugin consists of a single shell script (`worktree.plugin.zsh`) that defines:

### Core Functions
- `worktree()` - Main function to create/switch to worktrees
- `worktree-remove()` - Remove worktrees
- `git_root()` - Navigate to Git repository root
- `origin_branch()` - List remote branches sorted by commit date

### Configuration System
The plugin uses environment variables for configuration:
- `WORKTREE_CODE_DIR` - Directory pattern for project discovery
- `WORKTREE_CODE_EDITOR` - IDE command for opening worktrees
- `WORKTREE_POST_SWITCH` - Command executed after switching worktrees
- `WORKTREE_POST_CREATE` - Command executed after creating worktrees

### Shell Integration
- Tab completion for worktree names and branches
- Integration with Oh My Zsh plugin system
- Interactive confirmation prompts

## Development Notes

### Testing
This is a shell plugin - test manually by:
1. Loading the plugin in a Zsh session
2. Testing worktree creation/switching in a Git repository
3. Verifying tab completion works correctly

### Key Implementation Details
- Uses `git worktree` commands under the hood
- Automatically creates directory names with format: `../reponame-branchname`
- Handles both existing branches and new branch creation
- Provides fallback behavior when branches already exist in worktrees

### Shell Script Conventions
- Uses `#!/usr/bin/env zsh` shebang
- Follows Oh My Zsh plugin structure
- Uses `compdef` for tab completion definitions
- Exports functions for global availability