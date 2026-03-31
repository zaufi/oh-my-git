<!--
SPDX-FileCopyrightText: 2026 Alex Turbov <i.zaufi@gmail.com>

SPDX-License-Identifier: CC0-1.0
-->

# oh-my-git

This repository contains my Git configuration and a simple `Makefile` to install it.

## What Is In `gitconfig`

The configuration is opinionated toward a fast command-line workflow with signed history,
readable output, and branch-heavy development.

- `core`, `commit`, `format`, `tag`, and `user` enforce signing, sign-offs, and a predictable
  editing setup.
- `branch`, `pull`, `rebase`, `fetch`, `push`, `rerere`, and `worktree` favor a rebase-first
  workflow, automatic pruning, and easier multi-worktree use.
- `diff`, `merge`, `status`, `stash`, `grep`, `log`, `pretty`, and `pager` improve day-to-day
  inspection with richer diffs, verbose status, and custom
  log formats.
- `color.*`, `blame`, and `versionsort` mostly tune presentation by adding custom colors,
  recent-line highlighting in blame, and more natural tag sorting.

## Aliases

### Short command aliases

- `br`: `git branch -vv` for a verbose branch list with upstream tracking info.
- `ci`: `git commit`.
- `co`: `git checkout`.
- `cp`: `git cherry-pick`.
- `di`: `git diff`.
- `st`: `git status`.
- `sub`: `git submodule`.
- `wt`: `git worktree`.

### Shortcuts with built-in options

- `cl`: `git clone --recursive`.
- `cls`: shallow recursive clone with shallow submodules.
- `cs`: signed commit.
- `csnv`: signed commit without running hooks.
- `diw`: word-level diff.
- `fa`: fetch all remotes, tags, and prune stale refs.
- `fpush`: force-push with lease protection.
- `lg`: graph log using the custom compact format.
- `lgp`: detailed log with stats and patches.
- `prwt`: prune stale worktrees.
- `rba`: abort the current rebase.
- `rbc`: continue the current rebase.
- `rbs`: signed rebase.
- `rbsi`: signed interactive rebase.
- `rh`: hard reset.
- `sdi`: diff staged changes.
- `unstage`: unstage selected paths.
- `sw`: `git switch`.
- `swn`: create and switch to a new branch.
- `who`: contributor summary by author.

### Higher-level workflow aliases

- `clm`: clone into a `<project>/<main-branch>` layout and install
  `pre-commit` hooks if a `.pre-commit-config.yaml` file is found in the repo.
- `cslm`: signed commit that reuses the last edited commit message file. Very helpful when a commit
  message checking hook refuses the commit.
- `urls`: list configured remotes and their URLs.
- `aliases`: list configured Git aliases.
- `root`: print the repository root path.
- `amend-last`: amend the last commit with the current index, keeping its message.
- `edit-last`: amend the last commit message in the configured editor.
- `push-new-branch`: push the current branch to `origin` and set upstream tracking.
- `url-aliases`: show configured `url.*.insteadOf` shortcuts.
- `ls-extensions`: list distinct tracked file extensions in the repository.
- `worktree-add`: add an existing branch as a sibling worktree and initialize submodules when
  needed.
- `wta`: shorter alias for `worktree-add`.
- `worktree-branch`: create a new branch as a sibling worktree and initialize submodules when
  needed.
- `wtb`: shorter alias for `worktree-branch`.
- `prune-branches`: delete local branches whose upstream is gone after pruning `origin`.
- `prb`: shorter alias for `prune-branches`.

### Experimental or less-documented aliases

- `fxs`: create a signed fixup commit for a target revision and immediately run an autosquashing
  interactive rebase.

## Installation

By default, `make install` installs `gitconfig` as the system Git config and places
`commit-message.template` next to it:

```console
make install
```

To install it as the user config instead:

```console
make install user=1
```

System installs overwrite both destination files directly. User config installs refuse to
overwrite an existing destination unless `force=1` is set:

```console
make install user=1 force=1
```

`DESTDIR` is also supported for staged installs.
