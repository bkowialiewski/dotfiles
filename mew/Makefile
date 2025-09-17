# mew - dynamic menu for wayland
# See LICENSE file for copyright and license details.
.POSIX:

VERSION = 1.0

PKG_CONFIG = pkg-config

PREFIX    = /usr/local
MANPREFIX = $(PREFIX)/share/man

PKGS = fcft pixman-1 wayland-client xkbcommon
INCS != $(PKG_CONFIG) --cflags $(PKGS)
LIBS != $(PKG_CONFIG) --libs $(PKGS)

MWCPPFLAGS = -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -DVERSION=\"$(VERSION)\"
MWCFLAGS   = -pedantic -Wall $(INCS) $(MWCPPFLAGS) $(CFLAGS)
LDLIBS     = $(LIBS)

PROTO = wlr-layer-shell-unstable-v1-protocol.h xdg-activation-v1-protocol.h xdg-shell-protocol.h
SRC = mew.c $(PROTO:.h=.c)
OBJ = $(SRC:.c=.o)

all: mew

.c.o:
	$(CC) -o $@ $(MWCFLAGS) -c $<

config.h:
	cp config.def.h $@

$(OBJ): config.h $(PROTO)

mew: $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

WAYLAND_PROTOCOLS != $(PKG_CONFIG) --variable=pkgdatadir wayland-protocols
WAYLAND_SCANNER   != $(PKG_CONFIG) --variable=wayland_scanner wayland-scanner

xdg-activation-v1-protocol.h:
	$(WAYLAND_SCANNER) client-header $(WAYLAND_PROTOCOLS)/staging/xdg-activation/xdg-activation-v1.xml $@
xdg-activation-v1-protocol.c:
	$(WAYLAND_SCANNER) private-code $(WAYLAND_PROTOCOLS)/staging/xdg-activation/xdg-activation-v1.xml $@
xdg-shell-protocol.h:
	$(WAYLAND_SCANNER) client-header $(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@
xdg-shell-protocol.c:
	$(WAYLAND_SCANNER) private-code $(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@
wlr-layer-shell-unstable-v1-protocol.h:
	$(WAYLAND_SCANNER) client-header wlr-layer-shell-unstable-v1.xml $@
wlr-layer-shell-unstable-v1-protocol.c:
	$(WAYLAND_SCANNER) private-code wlr-layer-shell-unstable-v1.xml $@
wlr-layer-shell-unstable-v1-protocol.o: xdg-shell-protocol.o

clean:
	rm -f mew $(OBJ) $(PROTO:.h=.c) $(PROTO)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f mew mew-run $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/mew
	chmod 755 $(DESTDIR)$(PREFIX)/bin/mew-run
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < mew.1 > $(DESTDIR)$(MANPREFIX)/man1/mew.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/mew.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/mew \
		$(DESTDIR)$(PREFIX)/bin/mew-run \
		$(DESTDIR)$(MANPREFIX)/man1/mew.1

.PHONY: all clean install uninstall
