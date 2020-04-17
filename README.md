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
