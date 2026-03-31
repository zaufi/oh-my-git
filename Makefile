# SPDX-FileCopyrightText: 2026 Alex Turbov <i.zaufi@gmail.com>
# SPDX-License-Identifier: CC0-1.0

CONFIG_SOURCE := gitconfig
SYSTEM_CONFIG := /etc/$(CONFIG_SOURCE)
CONFIG_DEST := $(SYSTEM_CONFIG)
INSTALL_CMD := install -D -m 0644

# editorconfig-checker-disable
ifneq ($(user),)
    ifneq ($(user),1)
        $(error user must be 1 when specified)
    endif
    XDG_CONFIG_HOME ?= $(HOME)/.config
    USER_CONFIG := $(XDG_CONFIG_HOME)/git/config
    CONFIG_DEST := $(USER_CONFIG)
    ifneq ($(force),)
        ifneq ($(force),1)
            $(error force must be 1 when specified)
        endif
        INSTALL_CMD := $(INSTALL_CMD) -T
    endif
endif
# editorconfig-checker-enable

.PHONY: all install

all:
	:

install:
	@if test -n "$(user)" && test -e $(DESTDIR)$(CONFIG_DEST) && test "$(force)" != 1; then \
	    echo "Refusing to overwrite $(DESTDIR)$(CONFIG_DEST); use force=1 to override." >&2; \
	    exit 1; \
	fi
	$(INSTALL_CMD) $(CONFIG_SOURCE) $(DESTDIR)$(CONFIG_DEST)
