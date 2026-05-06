# myde.config

This repo contains my development environment config, typically dotfiles,
installed by [GNU stow](https://www.gnu.org/software/stow/manual/stow.html), using
[GNU make](https://www.gnu.org/software/make/manual/make.html/) and the targets
defined in the [Makefile](Makefile).

## Organization

``` text
.
├── .gitattributes
├── .gitignore
├── home/        # stow package of files to be symlinked under $HOME
├── Makefile     # project automation
└── README.md    # project documentation
```

## Usage

Run `make` with no arguments to list available targets.

``` text
$ make

Usage:
  make <target>

Info targets
  help             Show this help
  vars             Show environment variables used by this Makefile

Management targets
  preview          Preview config file symlinks
  link             Symlink config files
  adopt            Adopt existing config files
  unlink           Unlink config files
```

The `preview` target is used to preview the symlinks to be created, as well as
to report any warnings concerning files or directories existing at the path of
the symlink to be created.

The `link` target is the most common one, and simply symlinks config in the
repo into `$HOME`.

The `adopt` target is useful in cases where a file contained in this repo exists
in `$HOME` already, and thus cannot be symlinked. It copies over the existing
version under `$HOME` into the `home/` directory of this repo, overwriting its
contents. It is important to ensure that this git repo is clean before running
this target.

The `unlink target` removes the symlinks under `$HOME`, and files in this repo
are unaffected.
