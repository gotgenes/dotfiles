===================================
Chris Lasher's Shell Configurations
===================================

This is a collection of configuration files (a.k.a. "dot files") for
working in a \*NIX environment. This allows me to easily set up in a new
environment very quickly.

Presently this repository is tailored towards macOS. Some configuration
values may not be appropriate for Linux.

Deploying the configurations
============================

1.  Clone the Git repository::

      git clone git://github.com/gotgenes/shell-configs.git $HOME/shell-configs

    **NOTE**: Do *not* directly clone this into your ``$HOME``
    directory, *do* clone it into a subdirectory.

2.  Symbolically link the files into your ``$HOME`` directory::

      bash $HOME/shell-configs/symlink.sh

    **NOTE**: If you have any existing files, the script will not create
    symbolic links for files that already exist in ``$HOME``. To
    overwrite any existing configuration files in your home directory of
    the same name. I suggest running ``symlink.sh`` without the ``-f``
    flag first to see what files it might overwrite, then examining the
    existing files and looking for settings which you'd like to merge
    into the files in the ``shell-configs`` repository.

That's all there is to it! At this point, you will have successfully
deployed your configurations.

What's included?
================

The configurations include tweaks for

* bash: including a fancy prompt [1]_
* Version Control Systems (VCSes): particularly Git, but also Bazaar and
  Mercurial
* Vim: heavy configuration of Vim to make it much more productive,
  including support for a plugin manager, `vim-addon-manager`_ (VAM_)
  [2]_
* GNU Screen, including a custom status line

Please note that these configurations may contain settings very specific
to myself (e.g., email address) that should be changed by you if you
choose to fork the repository or otherwise use it.


.. _vim-addon-manager: VAM_
.. _VAM: https://github.com/MarcWeber/vim-addon-manager

.. [1]  I prefer the vi-style of command line editing over the EMACS
        style. If your preference is the EMACS-style, be sure to edit
        the appropriate lines in ``.inputrc`` and ``.bashrc``!

.. [2]  I found the best practice for plugin management was to tell the
        VCS to ignore the plugin directory (``.vim/vim-addons`` in the
        case of VAM_), and let the plugin manager fetch all the plugins,
        generate helptags, and do other initialization on the new system
        when firing up Vim for the first time. Otherwise the repository
        becomes a bit of a mess with ``.git``, ``.hg``, and ``.bzr``
        directories stored in the tree (or as git submodules), which
        causes too much noise.

