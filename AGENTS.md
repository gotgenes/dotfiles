# AGENTS Guide: dotfiles

## Project Overview

This is a personal dotfiles repository managed by [chezmoi](https://www.chezmoi.io/), targeting macOS (Apple Silicon) with some Linux support via chezmoi templates.
There is no build system, no test suite, and no CI/CD.

Primary configuration languages: **Lua** (Neovim/LazyVim), **Zsh**, **Bash**, and **Go templates** (chezmoi `.tmpl` files).
Supporting formats: TOML, YAML, HJSON, JSON.

## Repository Structure

```
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
│   └── opencode/            # OpenCode AI agent configuration
├── dot_local/bin/           # User scripts
└── dot_vim/                 # Legacy Vim configuration
```

### Chezmoi Naming Conventions

- `dot_` prefix: installed as `.filename` (e.g., `dot_zshenv` -> `~/.zshenv`)
- `private_dot_config/`: installed as `~/.config/` with restricted permissions
- `.tmpl` suffix: Go template files processed by chezmoi with variable substitution
- `executable_` prefix: installed with executable permissions
- Files without special prefixes are installed as-is

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

## Formatting

- **Lua**: StyLua (see configs above)
- **Markdown**: One sentence per line (unbroken) for better diffs
- **Shell**: No automated formatter; follow existing style

## Naming Conventions

| Context              | Convention                              | Example                          |
| -------------------- | --------------------------------------- | -------------------------------- |
| Lua locals/functions | `snake_case`                            | `diff_source`, `copy_selector`   |
| Lua exported helpers | `camelCase` (LazyVim convention)        | `M.rgbToHex`, `M.hslToHex`      |
| Shell variables      | `UPPER_SNAKE_CASE` for env vars         | `$EDITOR`, `$XDG_CONFIG_HOME`   |
| Shell functions      | `snake_case`                            | `source_if_exists`               |
| chezmoi files        | Follow chezmoi prefix conventions       | `dot_zshenv`, `private_dot_config` |

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

## OpenCode / Claude Path Compatibility

OpenCode's Claude compatibility layer rewrites `.opencode/` paths to `.claude/` (or `.Claude/`) in the system prompt sent to Claude models.
This means the model sees paths like `~/.config/Claude/AGENTS.md` and `.Claude/agents/`, but the actual files live under `opencode/` directories.

In this chezmoi repo, the mapping is:

| System prompt path                  | Actual file in this repo                          |
| ----------------------------------- | ------------------------------------------------- |
| `~/.config/Claude/AGENTS.md`       | `private_dot_config/opencode/AGENTS.md`           |
| `~/.config/Claude/agents/*.md`     | `private_dot_config/opencode/agents/*.md`         |
| `.Claude/` (project-level)          | Does not exist; this repo has no project-level config |

When reading or modifying agent configuration files, always use the `private_dot_config/opencode/` paths.

## Important Notes

- There are no tests or CI in this repository.
- The `dot_vimrc` is a legacy config superseded by the Neovim/LazyVim setup in `private_dot_config/nvim/`.
- The `.chezmoiignore` file prevents `README.md` and `.spl` spell files from being deployed.
- The primary target is macOS arm64; Linux support is handled via `{{ if eq .chezmoi.os "linux" }}` template conditionals.
- The user works with: Python, Go, TypeScript/JavaScript, Lua, C/C++, C#/.NET, Docker, SQL, LaTeX, Markdown, Terraform, Ruby, and more — filetype configs exist for all of these.
