
prefix = /usr

bindir = ${prefix}/bin
mandir = ${prefix}/share/man
localedir = ${prefix}/share/locale

INSTALL = /usr/bin/install -c
UNINSTALL = rm -f
MKDIR = mkdir -p

PO_FILES = i18n/tr.po

.PHONY: i18n
i18n: $(PO_FILES:po=mo)

%.mo: %.po
	msgfmt $< -o $@

makedir:
	test -d "$(DESTDIR)${bindir}" || $(MKDIR) "$(DESTDIR)${bindir}"
	test -d "$(DESTDIR)${mandir}/man1" || $(MKDIR) "$(DESTDIR)${mandir}/man1"
	test -d "$(DESTDIR)${mandir}/tr/man1" || $(MKDIR) "$(DESTDIR)${mandir}/tr/man1"
	test -d "$(DESTDIR)${localedir}/tr/LC_MESSAGES" || $(MKDIR) "$(DESTDIR)${localedir}/tr/LC_MESSAGES"

install: makedir
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
