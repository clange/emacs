# emacs
My Emacs configuration

* My `~/.emacs` file and several directories below `~/.emacs.d/` are symbolic links to a local clone of this Git repository.
  * Windows users, note that you can create native symbolic links with the `cmd` command `mklink`, at least on NTFS filesystems and [with administrator permissions](http://security.stackexchange.com/questions/10194/why-do-you-have-to-be-an-admin-to-create-a-symlink-in-windows).  This is useful when you are running a native Windows Emacs such as [emax](https://github.com/m-parashar/emax64/).
* My actual configuration files are modularised in the [emacs.d/init](emacs.d/init) directory.
* The files `emacs-*.el` are the `~/.emacs*.el` files I'm using on my various computers.  They load a subset of the configuration modules in [emacs.d/init](emacs.d/init).
* They generally first set up the load path, then load the desired modules, then perform some customisations that have not yet found their way into the modules.
* I installed most packages according to the configuration in [emacs.d/init/load-path-package.el](emacs.d/init/load-path-package.el).
* The files `emacs-*.el` and the directory `emacs.d` should actually have been named `.emacs-*.el` and `.emacs.d`, as that is the intended target name on your system.  The “non-dot” names are for easier searchability with standard tools, which default to ignoring hidden files.
