# Chris Lasher's Dotfiles

My collection of configuration files (a.k.a. "dot files") for working comfortably in a *NIX environment.
This repository is easily deployed with the help of [chezmoi](https://www.chezmoi.io/).

Presently this repository is tailored towards macOS. Some configuration
values may not be appropriate for Linux.

## Deploying the configurations

1.  [Install chezmoi](https://www.chezmoi.io/docs/install/)
2.  Initialize with chezmoi

    ```
    chezmoi init git@github.com:gotgenes/dotfiles.git
    ```

3.  Modify any necessary values in the `$XDG_CONFIG_HOME/chezmoi/chezmoi.toml` file:
4.  Apply the configurations

    ```
    chezmoi apply
    ```

That's all there is to it! At this point, you will have successfully deployed your configurations.

## Per-directory git identity

The git configuration supports per-directory identity overrides (e.g., using a different `user.email` for work repositories) via git's native [`includeIf`](https://git-scm.com/docs/git-config#_conditional_includes) mechanism.

The tracked git config includes `~/.config/git/config.local`, which is silently ignored if the file does not exist.
To set up per-directory identity on a given machine:

1.  Create `~/.config/git/config.local` with `includeIf` directives pointing to per-org config files:

    ```gitconfig
    [includeIf "gitdir:~/acmecorp/"]
        path = ~/.config/git/config.acmecorp
    ```

2.  Create the per-org config file (e.g., `~/.config/git/config.acmecorp`):

    ```gitconfig
    [user]
        email = you@acmecorp.com
    ```

Repositories cloned under `~/acmecorp/` will now use `you@acmecorp.com` as the commit author email, while all other repositories use the default email from the tracked git config.

Neither `config.local` nor the per-org config files are tracked by this repository, so organization names and work email addresses stay private.
