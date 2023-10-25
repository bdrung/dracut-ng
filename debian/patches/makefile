--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,7 @@
 ifeq ($(DRACUT_FULL_VERSION),)
 DRACUT_FULL_VERSION = $(DRACUT_VERSION)
 endif
+DRACUT_FULL_VERSION = $(shell dpkg-parsechangelog -SVersion)
 
 HAVE_SHELLCHECK ?= $(shell command -v shellcheck >/dev/null 2>&1 && echo yes)
 HAVE_SHFMT ?= $(shell command -v shfmt >/dev/null  2>&1 && echo yes)
