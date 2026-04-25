<!--
SPDX-FileCopyrightText: 2026 Alex Turbov <i.zaufi@gmail.com>

SPDX-License-Identifier: CC0-1.0
-->

# oh-my-git

This repository contains my Git configuration, helper scripts, and a small CMake-based install
setup.

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

In the descriptions below, a Git command (verb) may be `emphasized` to hint at the underlying
command behind the corresponding alias.

### Short command aliases

- `ci`: `git commit`.
- `co`: `git checkout`.
- `cp`: `git cherry-pick`.
- `di`: `git diff`.
- `st`: `git status`.
- `sub`: `git submodule`.
- `sw`: `git switch`.
- `wt`: `git worktree`.

### Shortcuts with built-in options

- `br`: `git branch -vv` for a verbose branch list with upstream tracking info.
- `cl`: `git clone --recursive`.
- `cls`: shallow recursive `clone` with shallow submodules
  (`--recursive --depth 1 --shallow-submodules`).
- `cs`: signed `commit` (`-S`).
- `csnv`: signed `commit` without running hooks (`--no-verify`).
- `diw`: word-level `diff` (`--word-diff`).
- `fa`: `fetch` all remotes, tags, and prune stale refs.
- `fpush`: force-`push` with lease protection.
- `lg`: graph `log` using the custom compact format.
- `lgp`: detailed `log` with stats and patches.
- `prwt`: prune stale worktrees. Run after removing some worktrees manually (e.g., with `rm -rf`).
- `rbs`: signed `rebase`.
- `rbsi`: signed interactive `rebase`.
- `rba`: abort the current `rebase`.
- `rbc`: continue the current `rebase`.
- `rh`: hard `reset`.
- `sdi`: `diff` staged changes.
- `unstage`: unstage selected paths.
- `swn`: create and `switch` to a new branch.
- `who`: contributor summary by author.

### Higher-level workflow aliases

- `clm`: clone into a `<project>/<main-branch>` layout and install `pre-commit` hooks if a
  `.pre-commit-config.yaml` file is found in the repository. Using `main-branch` as a subdirectory
  is convenient when working with multiple worktrees, with other development branches placed
  alongside it under the `<project>/` directory.
- `cslm`: signed `commit` that reuses the last edited commit message file. Very helpful when a commit
  message validation hook refuses the commit.
- `urls`: list configured remotes and their URLs.
- `aliases`: list configured Git aliases.
- `root`: print the repository root path.
- `amend-last`: `amend` the last commit with the current index, keeping its message.
- `edit-last`: `amend` the last commit message in the configured editor.
- `push-new-branch`: `push` the current branch to `origin` and set upstream tracking.
- `url-aliases`: show configured `url.*.insteadOf` shortcuts.
- `ls-extensions`: list distinct tracked file extensions in the repository.
- `worktree-checkout`: add existing branches as sibling worktrees and initialize submodules when
  needed. Pass `--all` or `-a` to check out every local branch not checked out yet.
- `wtco`: shorter alias for `worktree-checkout`.
- `wtcoi`: interactively choose local branches and check them out as sibling worktrees.
- `worktree-branch`: create a new branch as a sibling worktree and initialize submodules when
  needed.
- `wtb`: shorter alias for `worktree-branch`.
- `select-worktree`: interactively choose a worktree and print its directory to stdout. It colors
  each branch by clean/dirty status. Pass `-m` to enable multi-select in `sk`, or `--header <text>`
  to set the `sk` header.
- `wtdir`: shorter legacy alias for `select-worktree`.
- `prune-branches`: delete local branches whose upstream is gone after pruning `origin`.
- `prb`: shorter alias for `prune-branches`.
- `select-branch`: interactively choose local branch names and print them to stdout. Pass `-m`
  to enable multi-select in `sk`; any other arguments are passed to `git branch`.
- `swi`: interactively choose a local branch and `switch` to it. Pass `-m` to enable multi-select
  before piping the result into `git switch` one branch at a time.

### Experimental or less-documented aliases

- `fxs <commit-options> <commit-hash>`: create a signed fixup commit for a target revision, then
  immediately run an autosquashing interactive rebase.

> [!CAUTION]
> Use `git fxs -a <commit-hash>` or make sure there are no unstaged changes in the repository when you
> run it.

## Scripts

The repository also installs small helper scripts that support the aliases and can be used directly.

- `git-select-branch`: display branch lines in `sk` (skim), print the selected branch name or names
  to stdout, and support forwarding branch-selection flags to `git branch` after `--`. It can keep
  or hide worktree branches, the current branch, and symbolic `*/HEAD` refs via its own options.
- `git-select-worktree`: display worktrees in `sk` (skim), coloring branches by clean/dirty status,
  and print the selected worktree directory or directories to stdout. Pass `-m` to enable
  multi-select, or `--header <text>` to set the `sk` header.
- `git-worktree-checkout`: add existing branches as sibling worktrees and initialize submodules
  when needed. Pass `--all` or `-a` to check out every local branch not checked out yet.
- `gh-select-pr`: display open GitHub pull requests in `sk` (skim), preview the selected PR body,
  and print the selected PR number to stdout. Extra arguments after `--` are passed to `gh pr list`.

## Installation

By default, configuring and installing with CMake installs:

- `gitconfig` as `/usr/local/etc/gitconfig`
- `commit-message.template` as `/usr/local/etc/commit-message.template`
- `scripts/gh-select-pr` as `/usr/local/libexec/gh-select-pr`
- `scripts/git-select-branch` as `/usr/local/libexec/git-select-branch`
- `scripts/git-select-worktree` as `/usr/local/libexec/git-select-worktree`
- `scripts/git-worktree-checkout` as `/usr/local/libexec/git-worktree-checkout`

```console
cmake -S . -B build
cmake --install build
```

To install under a different prefix, set `CMAKE_INSTALL_PREFIX`:

```console
cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$HOME/.local"
cmake --install build
```

To override individual install directories, pass the usual `GNUInstallDirs` cache entries such as
`CMAKE_INSTALL_SYSCONFDIR` and `CMAKE_INSTALL_LIBEXECDIR`:

```console
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_INSTALL_SYSCONFDIR=/etc \
  -DCMAKE_INSTALL_LIBEXECDIR=/usr/libexec
cmake --install build
```

`DESTDIR` is also supported for staged installs via `cmake --install build --prefix ...` or the
usual `DESTDIR=/path cmake --install build` flow.
