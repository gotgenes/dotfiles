# Chris Lasher's Dotfiles

My collection of configuration files (a.k.a. "dot files") for working comfortably in a \*NIX environment.
This repository is easily deployed with the help of [chezmoi](https://www.chezmoi.io/).

Presently this repository is tailored towards macOS. Some configuration
values may not be appropriate for Linux.

## Deploying the configurations

1. [Install chezmoi](https://www.chezmoi.io/docs/install/)
2. Initialize with chezmoi

   ```sh
   chezmoi init git@github.com:gotgenes/dotfiles.git
   ```

3. Modify any necessary values in the `$XDG_CONFIG_HOME/chezmoi/chezmoi.toml` file:
4. Apply the configurations

   ```sh
   chezmoi apply
   ```

That's all there is to it! At this point, you will have successfully deployed your configurations.

## Per-directory git identity

The git configuration supports per-directory identity overrides (e.g., using a different `user.email` for work repositories) via git's native [`includeIf`](https://git-scm.com/docs/git-config#_conditional_includes) mechanism.

The tracked git config includes `~/.config/git/config.local`, which is silently ignored if the file does not exist.
To set up per-directory identity on a given machine:

1. Create `~/.config/git/config.local` with `includeIf` directives pointing to per-org config files:

   ```gitconfig
   [includeIf "gitdir:~/acmecorp/"]
       path = ~/.config/git/config.acmecorp
   ```

2. Create the per-org config file (e.g., `~/.config/git/config.acmecorp`):

   ```gitconfig
   [user]
       email = you@acmecorp.com
   ```

Repositories cloned under `~/acmecorp/` will now use `you@acmecorp.com` as the commit author email, while all other repositories use the default email from the tracked git config.

Neither `config.local` nor the per-org config files are tracked by this repository, so organization names and work email addresses stay private.

## Per-directory GitHub CLI account

If you have multiple GitHub accounts authenticated with `gh auth login`, the included `gh` wrapper script (`~/.local/bin/gh`) can automatically select the correct account based on your working directory.

The wrapper checks for a `GH_USER` environment variable.
If set, it fetches that user's token from the keyring and passes it to `gh` via `GH_TOKEN` for the current invocation, without changing the globally active account.
If `GH_USER` is not set, `gh` behaves normally with the default active account.

To configure per-directory account switching using [mise](https://mise.jdx.dev/):

1. Authenticate both accounts:

   ```sh
   gh auth login  # default account
   gh auth login  # work account
   ```

2. Set your default account as active:

   ```sh
   gh auth switch -u your-default-username
   ```

3. Create a `mise.toml` in the work directory (e.g., `~/acmecorp/mise.toml`):

   ```toml
   [env]
   GH_USER = "your-work-username"
   ```

Any `gh` command run from `~/acmecorp/` or its subdirectories will now use the work account.
The `mise.toml` files are not tracked by this repository, keeping account names private.
