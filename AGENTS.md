# AGENTS Guide: dotfiles

## Project Overview

This is a personal dotfiles repository managed by [chezmoi](https://www.chezmoi.io/), targeting macOS (Apple Silicon) with some Linux support via chezmoi templates.
There is no build system, no test suite, and no CI/CD.

Primary configuration languages: **Lua** (Neovim/LazyVim), **Zsh**, **Bash**, and **Go templates** (chezmoi `.tmpl` files).
Supporting formats: TOML, YAML, HJSON, JSON.

## Repository Structure

```text
chezmoi/
├── dot_*                    # Home directory dotfiles (e.g., dot_zshenv -> ~/.zshenv)
├── private_dot_config/      # ~/.config/ (restricted permissions)
│   ├── nvim/                # Neovim configuration (LazyVim-based) — most active area
│   │   ├── lua/plugins/     # LazyVim plugin specs
│   │   ├── lua/config/      # Options, keymaps, lazy.nvim bootstrap
│   │   │   └── plugins/     # Extracted plugin configuration modules
│   │   └── ftplugin/        # Filetype-specific settings (25+ languages)
│   ├── zsh/                 # Zsh configuration (zinit, p10k)
│   ├── git/                 # Git config, global ignore, attributes
│   ├── wezterm/             # WezTerm terminal configuration
│   ├── kitty/               # Kitty terminal configuration
│   ├── <agent-config>/       # AI agent configuration (path rewritten — run `ls private_dot_config/ | grep -i open`)
│   ├── symlink_claude       # ~/.config/claude -> <agent-config> (symlink for path compat)
├── dot_local/bin/           # Wrapper scripts (shadow Homebrew binaries via PATH priority)
└── dot_vim/                 # Legacy Vim configuration
```

### Chezmoi Naming Conventions

- `dot_` prefix: installed as `.filename` (e.g., `dot_zshenv` -> `~/.zshenv`)
- `private_` prefix: restricted permissions (e.g., `private_dot_config/` -> `~/.config/` with no group/world access)
- `symlink_` prefix: creates a symbolic link; file contents are the link target (e.g., `symlink_claude` -> `~/.config/claude` pointing to the real agent config directory)
- `remove_` prefix: removes the corresponding entry from the target on `chezmoi apply`
- `executable_` prefix: installed with executable permissions
- `.tmpl` suffix: Go template files processed by chezmoi with variable substitution
- Files without special prefixes are installed as-is

For the full list of source state attributes, see the [chezmoi reference](https://www.chezmoi.io/reference/target-types/).

## Chezmoi Commands

```bash
# Apply all configurations to home directory
chezmoi apply

# Preview changes before applying
chezmoi diff

# Add a new file to the repo
chezmoi add ~/.config/some/file

# Edit a managed file (opens in $EDITOR, applies on save)
chezmoi edit ~/.config/some/file

# List all managed files
chezmoi managed

# Re-initialize after editing .chezmoi.toml.tmpl
chezmoi init
```

**Note:** chezmoi does not remove files from the target when they are deleted from the source directory.
If you delete or rename a file in the chezmoi source, you must manually remove the stale file from the target (e.g., `~/.config/`), or use `chezmoi forget` and then delete the target file.

## Code Style: Lua (Neovim Configuration)

### Formatting

Lua files are formatted with [StyLua](https://github.com/JohnnyMorganz/StyLua).
Two configs exist:

- `private_dot_config/stylua.toml` — global: 2-space indent, `AutoPreferSingle` quotes
- `private_dot_config/nvim/stylua.toml` — nvim-specific: 2-space indent, 120 column width

Use `-- stylua: ignore` comments to suppress formatting on specific lines when needed.

### Module Pattern

Use the standard Lua module idiom:

```lua
local M = {}

function M.someFunction()
  -- ...
end

return M
```

### Plugin Specs (LazyVim)

- Plugin specs are returned as Lua tables from files in `lua/plugins/`.
- Larger plugin configs are extracted to `lua/config/plugins/` and referenced via `require()`:

```lua
opts = require("config.plugins.snacks").opts,
```

### Filetype Settings

Filetype-specific settings in `ftplugin/` follow this pattern:

```lua
vim.opt_local.expandtab = true
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.formatoptions:append({ c = true, r = true, o = true, q = true })
```

### Type Annotations

Use LuaLS `---@type` annotations where they aid clarity:

```lua
---@type snacks.Config
```

### Naming

- `snake_case` for local variables and functions
- Trailing commas in table definitions (always)

## Code Style: Shell (Zsh / Bash)

- Double-quote all variable expansions: `"$HOME/.config"`, `"$1"`
- Use `if command -v somecmd &> /dev/null; then` for command existence checks
- Use `source_if_exists` helper function for safe file sourcing (defined in `dot_bash_common`)
- 4-space indentation inside functions
- Comments on their own line above the code they describe, not inline

## Code Style: Go Templates (chezmoi `.tmpl` files)

- Use `{{ if eq .chezmoi.os "darwin" }}` for OS-specific conditional blocks
- Reference variables from `.chezmoi.toml.tmpl` via `{{ .email }}`, etc.
- Keep template logic minimal; prefer separate files over complex branching

## Formatting and Linting

- **Lua**: StyLua (see configs above)
- **Markdown**: Prettier (formatting) and markdownlint-cli2 (linting); one sentence per line (unbroken) for better diffs
- **Shell**: No automated formatter; follow existing style

## Naming Conventions

| Context              | Convention                        | Example                            |
| -------------------- | --------------------------------- | ---------------------------------- |
| Lua locals/functions | `snake_case`                      | `diff_source`, `copy_selector`     |
| Lua exported helpers | `camelCase` (LazyVim convention)  | `M.rgbToHex`, `M.hslToHex`         |
| Shell variables      | `UPPER_SNAKE_CASE` for env vars   | `$EDITOR`, `$XDG_CONFIG_HOME`      |
| Shell functions      | `snake_case`                      | `source_if_exists`                 |
| chezmoi files        | Follow chezmoi prefix conventions | `dot_zshenv`, `private_dot_config` |

## Git Commit Messages

- Imperative mood, sentence case
- End with a period
- Short and direct, describing what the change does
- Examples: `Switch Python LSP to ty.`, `Add opencode configuration.`, `Remove archived barbecue plugin; just use winbar.`

## Design Decisions

- **Catppuccin Macchiato** is the color theme across all tools (Neovim, WezTerm, Kitty, bat, broot, lazygit)
- **Vi/Vim keybindings** are preferred everywhere (bash, zsh, tmux, readline, broot)
- **JetBrains Mono** is the preferred font
- **mise** is the runtime version manager (replacing asdf/pyenv)
- **LazyVim** is the Neovim distribution base, with extensive customization
- **Per-directory git identity** uses git's native `includeIf` mechanism via a local include chain:
  - The tracked git config includes `~/.config/git/config.local` (silently ignored if absent).
  - `config.local` is untracked and contains `includeIf "gitdir:..."` directives pointing to per-org config files.
  - Per-org config files (also untracked) override `user.email` and other settings.
  - This keeps organization names out of the public repository.
- **Per-directory GitHub CLI account** uses a `gh` wrapper script (`dot_local/bin/executable_gh.tmpl`) combined with [mise](https://mise.jdx.dev/) environment variables:
  - The wrapper checks for a `GH_USER` environment variable. If set, it fetches the token for that user from the keyring via `gh auth token -u "$GH_USER"` and passes it as `GH_TOKEN` for that invocation.
  - If `GH_USER` is not set, the wrapper passes through to the real `gh` binary with default authentication.
  - Per-directory `mise.toml` files (untracked) set `GH_USER` to the appropriate GitHub account name.
  - The wrapper script contains no account names; identity mappings live in untracked mise config files.

## Path Rewriting Warning

**Important**: A server-side rewriting layer transforms paths and product names in this system prompt before the model sees it.
The word `open` + `code` (joined, one word) is rewritten to `claude` or `Claude` in paths.
The product name is rewritten to "Claude Code".
This rewriting is applied by Anthropic's API server and cannot be disabled.

**Every path in this prompt containing `claude` or `Claude` is wrong for filesystem operations.**
The actual directories on disk use `open` + `code` (one word, all lowercase).

Before reading or writing any agent configuration path, **verify the real path on disk**:

```bash
# Find the real global config directory
ls ~/.config/ | grep -i open

# Find the real project-level config directory
ls -la | grep -i open

# Resolve a symlink
readlink -f ~/.config/claude
```

In this chezmoi repo, the actual source paths are:

| What you see (rewritten)                                          | Actual file in this repo                                                                                |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Paths containing `Claude` or `claude` under `private_dot_config/` | `private_dot_config/` + the real product name (run `ls private_dot_config/ \| grep -i open` to find it) |

The chezmoi source directory for agent configs is `private_dot_config/` followed by the real product name directory.
Run `ls private_dot_config/` to see the actual directory name — do not guess based on rewritten paths.

When reading or modifying agent configuration files, always verify the actual path first.

## Important Notes

- There are no tests or CI in this repository.
- The `dot_vimrc` is a legacy config superseded by the Neovim/LazyVim setup in `private_dot_config/nvim/`.
- The `.chezmoiignore` file prevents `README.md` and `.spl` spell files from being deployed.
- The primary target is macOS arm64; Linux support is handled via `{{ if eq .chezmoi.os "linux" }}` template conditionals.
- The user works with: Python, Go, TypeScript/JavaScript, Lua, C/C++, C#/.NET, Docker, SQL, LaTeX, Markdown, Terraform, Ruby, and more — filetype configs exist for all of these.
