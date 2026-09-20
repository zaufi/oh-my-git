# SPDX-FileCopyrightText: 2026 Alex Turbov <i.zaufi@gmail.com>
# SPDX-License-Identifier: CC0-1.0

cmake_minimum_required(VERSION 4.3)

project(
    oh-my-git
    VERSION 0.1.0
    DESCRIPTION "Opinionated Git configuration and helper scripts"
    HOMEPAGE_URL "https://github.com/zaufi/oh-my-git"
    LANGUAGES NONE
  )

# Avoid GNUInstallDirs warning for a project that installs only data/scripts.
set(CMAKE_SIZEOF_VOID_P 8)
include(GNUInstallDirs)

cmake_host_system_information(RESULT DISTRIB_NAME QUERY DISTRIB_NAME)
cmake_path(APPEND CMAKE_INSTALL_SYSCONFDIR profile.d OUTPUT_VARIABLE CMAKE_INSTALL_SHELL_PROFILEDIR)
# NOTE Exherbo has `/etc/bash/bashrc.d/` for interactive shells
# TODO Add other distros with this feature
if(DISTRIB_NAME STREQUAL "Exherbo")
    cmake_path(APPEND CMAKE_INSTALL_SYSCONFDIR bash/bashrc.d OUTPUT_VARIABLE CMAKE_INSTALL_SHELL_PROFILEDIR)
    set(_OMG_INTERACTIVE_SHELL_CHECK "")
else()
    # NOTE For other distros install out files to `/etc/profile.d/`
    # and put interactive shell check in it
    set(
        _OMG_INTERACTIVE_SHELL_CHECK
        "\n# Only load in interactive Bash shells.\n[[ $- == *i* ]] || return\n"
      )
endif()

cmake_path(
    APPEND CMAKE_INSTALL_FULL_SYSCONFDIR git
    OUTPUT_VARIABLE COMMIT_MESSAGE_TEMPLATE_INSTALL_DIR
  )
cmake_path(
    APPEND COMMIT_MESSAGE_TEMPLATE_INSTALL_DIR commit-message.template
    OUTPUT_VARIABLE COMMIT_MESSAGE_TEMPLATE
  )
configure_file(gitconfig gitconfig @ONLY)
configure_file(profile.d/oh-my-git-keybindings.sh.in profile.d/oh-my-git-keybindings.sh @ONLY)

install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/gitconfig"
    DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}"
  )

install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/profile.d/oh-my-git-keybindings.sh"
    DESTINATION "${CMAKE_INSTALL_SHELL_PROFILEDIR}"
  )

install(
    FILES "${CMAKE_CURRENT_SOURCE_DIR}/commit-message.template"
    DESTINATION "${COMMIT_MESSAGE_TEMPLATE_INSTALL_DIR}"
  )

install(
    PROGRAMS
        "${CMAKE_CURRENT_SOURCE_DIR}/scripts/gh-select-pr"
        "${CMAKE_CURRENT_SOURCE_DIR}/scripts/git-select-branch"
        "${CMAKE_CURRENT_SOURCE_DIR}/scripts/git-select-worktree"
        "${CMAKE_CURRENT_SOURCE_DIR}/scripts/git-worktree-checkout"
    DESTINATION "${CMAKE_INSTALL_LIBEXECDIR}"
  )
