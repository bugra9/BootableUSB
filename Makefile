
prefix = /usr

bindir = ${prefix}/bin
mandir = ${prefix}/share/man
localedir = ${prefix}/share/locale

INSTALL = /usr/bin/install -c
UNINSTALL = rm -f

PO_FILES = i18n/tr.po

.PHONY: i18n
i18n: $(PO_FILES:po=mo)

%.mo: %.po
	msgfmt $< -o $@

install:
	$(INSTALL) -m 755 src/bootableusb \
	                  "$(DESTDIR)$(bindir)/bootableusb"
	$(INSTALL) -m 644 man/bootableusb.1.en \
	                  "$(DESTDIR)$(mandir)/man1/bootableusb.1"
	$(INSTALL) -m 644 man/bootableusb.1.tr \
	                  "$(DESTDIR)$(mandir)/tr/man1/bootableusb.1"
	$(INSTALL) -m 644 i18n/tr.mo \
	                  "$(DESTDIR)$(localedir)/tr/LC_MESSAGES/bootableusb.mo"

uninstall:
	-$(UNINSTALL) "$(DESTDIR)$(bindir)/bootableusb"
	-$(UNINSTALL) "$(DESTDIR)$(mandir)/man1/bootableusb.1"
	-$(UNINSTALL) "$(DESTDIR)$(mandir)/man1/bootableusb.1.gz"
	-$(UNINSTALL) "$(DESTDIR)$(mandir)/tr/man1/bootableusb.1"
	-$(UNINSTALL) "$(DESTDIR)$(mandir)/tr/man1/bootableusb.1.gz"
	-$(UNINSTALL) "$(DESTDIR)$(localedir)/tr/LC_MESSAGES/bootableusb.mo"

clean:
	-$(UNINSTALL) i18n/*.mo
