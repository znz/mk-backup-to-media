TEXTDOMAIN = mk-backup-to-media
LANGS = ja
SRC = common-functions mk-backup-to-media

all: makemo

updatepo:
	xgettext -o po/$(TEXTDOMAIN).pot -L Shell $(SRC)
	for lang in $(LANGS); do \
		if [ -f po/$$lang.po ]; then \
			mv po/$$lang.po po/$$lang.po~; \
			msgmerge po/$$lang.po~ po/$(TEXTDOMAIN).pot -o po/$$lang.po; \
		fi \
	done

makemo:
	for lang in $(LANGS); do \
		if [ -f po/$$lang.po ]; then \
			mkdir -p locale/$$lang/LC_MESSAGES; \
			msgfmt -o locale/$$lang/LC_MESSAGES/$(TEXTDOMAIN).mo po/$$lang.po; \
		fi \
	done

install:
	for lang in $(LANGS); do \
		if [ -f po/$$lang.po ]; then \
			install -m644 -D locale/$$lang/LC_MESSAGES/$(TEXTDOMAIN).mo $(DESTDIR)/usr/share/locale/$$lang/LC_MESSAGES/$(TEXTDOMAIN).mo; \
		fi \
	done
