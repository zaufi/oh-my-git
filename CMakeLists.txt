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

configure_file(gitconfig gitconfig @ONLY)

install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/gitconfig"
    DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}"
)

install(
    FILES "${CMAKE_CURRENT_SOURCE_DIR}/commit-message.template"
    DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}"
)

install(
    PROGRAMS
        "${CMAKE_CURRENT_SOURCE_DIR}/scripts/gh-select-pr"
        "${CMAKE_CURRENT_SOURCE_DIR}/scripts/git-select-branch"
    DESTINATION "${CMAKE_INSTALL_LIBEXECDIR}"
)
