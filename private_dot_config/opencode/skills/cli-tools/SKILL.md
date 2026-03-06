---
name: cli-tools
description: Modern CLI tool equivalents installed on this system (fd, rg, eza, bat, sd, etc.) with usage examples
---

## CLI Tools

This system has modern CLI tools installed via Homebrew.
Prefer these over their traditional counterparts when running shell commands.

| Modern tool         | Replaces                    | Notes                                                  |
| ------------------- | --------------------------- | ------------------------------------------------------ |
| `fd`                | `find`                      | Simpler syntax, respects `.gitignore` by default       |
| `rg` (ripgrep)      | `grep`                      | Faster, respects `.gitignore`, better defaults         |
| `eza`               | `ls`                        | `--tree`, `--git`, `--icons` flags available           |
| `bat`               | `cat`                       | Syntax highlighting, line numbers, git integration     |
| `sd`                | `sed`                       | Simpler regex syntax (uses literal strings by default) |
| `dust`              | `du`                        | Visual, sorted disk usage                              |
| `procs`             | `ps`                        | Colored, searchable process listing                    |
| `jq`                | —                           | JSON filtering and transformation                      |
| `fzf`               | —                           | Fuzzy finder for interactive selection                 |
| `zoxide`            | `cd` (frequent dirs)        | Tracks frecency for fast directory jumping             |
| `tealdeer` (`tldr`) | `man` (for quick reference) | Community-maintained command cheat sheets              |
| `viddy`             | `watch`                     | Modern watch with diff highlighting                    |
| `tree`              | `ls -R`                     | Directory tree visualization                           |
| `broot`             | —                           | Interactive file tree and navigation                   |
| `lazygit`           | —                           | Terminal UI for git                                    |
| `git-delta`         | `diff`                      | Configured as git's default pager for diffs            |
| `shellcheck`        | —                           | Shell script static analysis                           |
| `codespell`         | —                           | Spell checker for source code                          |

## Usage Examples

- Use `fd` instead of `find` for locating files.
  Example: `fd '\.ts$'` instead of `find . -name '*.ts'`.
- Use `rg` instead of `grep` for searching file contents.
  Example: `rg 'TODO'` instead of `grep -r 'TODO' .`.
- Use `bat` instead of `cat` when showing file contents to the user (it adds syntax highlighting).
  For piping into other commands, plain `cat` is fine.
- Use `sd` instead of `sed` for simple find-and-replace.
  Example: `sd 'old' 'new' file.txt` instead of `sed -i '' 's/old/new/g' file.txt`.
- Use `dust` instead of `du` for disk usage analysis.
- Use `jq` for any JSON processing in shell pipelines.
- Use `eza` instead of `ls` when a richer listing is helpful (e.g., `eza -la --git`).
