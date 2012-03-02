===================================
Chris Lasher's Shell Configurations
===================================

This is a collection of configuration files (a.k.a. "dot files") for
working in a \*NIX environment. This allows me to easily set up in a new
environment very quickly.

Deploying the configurations
============================

1. Clone the Git repository::

    git clone git://github.com/gotgenes/shell-configs.git $HOME/shell-configs

  **NOTE**: Do *not* directly clone this into your ``$HOME`` directory,
  *do* clone it into a subdirectory.

2. Symbolically link the files into your ``$HOME`` directory::

    cd $HOME/shell-configs/
    ./symlink.sh -f    # overwrites files in $HOME; see comment below

  **NOTE**: This will overwrite any existing configuration files in your
  home directory of the same name. You can try running ``symlink.sh``
  without the ``-f`` flag first to see what files it might overwrite,
  then examine the existing files and look for settings which you'd like
  to merge into the files in the Git repository.

That's all there is to it! At this point, you will have successfully
deployed your configurations.

What's included?
================

The configurations include tweaks for

* bash: including a fancy prompt
* Version Control Systems (VCSes): particularly Git, but also Bazaar and
  Mercurial
* Vim: heavy configuration of Vim to make it much more productive,
  including support for a plugin manager, `vim-addon-manager`_ (VAM_)
* GNU Screen, including a custom status line

Please note that these configurations may contain settings very specific
to myself (e.g., email address) that should be changed by you if you
choose to fork the repository or otherwise use it.


.. _vim-addon-manager: VAM_
.. _VAM: https://github.com/MarcWeber/vim-addon-manager
