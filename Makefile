VERSION = 1.0

CC	?= gcc
CFLAGS += -Wall -std=c99 -Os -DVERSION="\"$(VERSION)\"" -I/usr/include/freetype2
LDFLAGS += -lxcb -lxcb-xinerama -lxcb-randr -lX11 -lX11-xcb -lXft -lfreetype -lz -lfontconfig
CFDEBUG = -g3 -pedantic -Wall -Wunused-parameter -Wlong-long \
          -Wsign-conversion -Wconversion -Wimplicit-function-declaration

EXEC = aebar
SRCS = aebar.c
OBJS = ${SRCS:.c=.o}

PREFIX?=/usr
BINDIR=${PREFIX}/bin

all: ${EXEC}

doc: man.pod
	pod2man --section=1 --center="aebar manual" --name "aebar" --release="aebar $(VERSION)" man.pod > aebar.1

debug: ${EXEC}
debug: CC += ${CFDEBUG}

clean:
	rm -f ./*.o ./*.1
	rm -f ./${EXEC}

install: aebar doc
	install -D -m 755 aebar ${DESTDIR}${BINDIR}/aebar
	install -D -m 644 aebar.1 ${DESTDIR}${PREFIX}/share/man/man1/aebar.1

uninstall:
	rm -f ${DESTDIR}${BINDIR}/aebar
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/aebar.1
