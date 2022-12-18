# Makefile for creating Windows CE release archives, with the mingw32ce compiler.
# Last updated: 22-Jul-2008

# Copyright (C) 2008 Vincent Torri

# To get some help, type
#
# make help
#
# To create the archives
#
# make
#
# To remove everything, type:
#
# make clean

VERMAJ = 2
VERMIN = 3
VERMIC = 7
VER = $(VERMAJ).$(VERMIN).$(VERMIC)
NAME = freetype
PACKAGE = $(NAME)-$(VER)

BIN = libfreetype-6.dll
LIB = libfreetype.a libfreetype.dll.a
INCLUDE = include/ft2build.h include/freetype/
PC = builds/unix/freetype2.pc

MANIFESTVERBIN = "Freetype-$(VER): Binary files"
MANIFESTVERDEV = "Freetype-$(VER): Developer files"
MANIFESTVERDESC = "Freetype: A Free, High-Quality, and Portable Font Engine"

all: $(NAME)

$(NAME): remove-old copy-src compilation copy manifest archive
	@echo " * Removal of the directories"
	@rm -rf $(PACKAGE)/ $(PACKAGE)-bin/ $(PACKAGE)-dev/

remove-old:
	@echo " * Removal of the old files"
	@rm -rf $(PACKAGE)-bin*
	@rm -rf $(PACKAGE)-dev*

copy-src:
	@echo " * Copy of source files"
	@cp -R ../src/$(PACKAGE) .
	@echo " * Creation of directories and files"
	@mkdir -p $(PACKAGE)-bin/bin
	@mkdir -p $(PACKAGE)-bin/manifest
	@mkdir -p $(PACKAGE)-dev/lib/pkgconfig
	@mkdir -p $(PACKAGE)-dev/include/freetype2
	@mkdir -p $(PACKAGE)-dev/manifest
	@touch $(PACKAGE)-bin/manifest/$(PACKAGE)-bin.mft
	@touch $(PACKAGE)-bin/manifest/$(PACKAGE)-bin.ver
	@touch $(PACKAGE)-dev/manifest/$(PACKAGE)-dev.mft
	@touch $(PACKAGE)-dev/manifest/$(PACKAGE)-dev.ver

compilation:
	@echo " * Compilation of $(PACKAGE)"
	cd $(PACKAGE) && CPPFLAGS="$(CPPFLAGS) -D_WIN32_WCE=0x0420 -DFT_CONFIG_OPTION_SYSTEM_ZLIB -DFT_CONFIG_CONFIG_H=\"<ftconfig.h>\"" CFLAGS="$(CFLAGS) -O3 -fms-extensions -mms-bitfields -fno-exceptions -fomit-frame-pointer -ffast-math -pipe" LDFLAGS="$(LDFLAGS) -Wl,--enable-auto-import -Wl,--force-exe-suffix -Wl,--enable-runtime-pseudo-reloc -Wl,--allow-multiple-definition -Wl,--enable-stdcall-fixup -Wl,-s" ./configure --prefix=/opt/wince --host=arm-mingw32ce && make

copy:
	@echo " * Copy of binary and development files"
	@for i in $(BIN); do \
	  cp $(PACKAGE)/objs/.libs/$$i $(PACKAGE)-bin/bin; \
	done
	@for i in $(LIB); do \
	  cp $(PACKAGE)/objs/.libs/$$i $(PACKAGE)-dev/lib; \
	done
	@for i in $(INCLUDE); do \
	  cp -R $(PACKAGE)/$$i $(PACKAGE)-dev/include/freetype2; \
	done
	@for i in $(PC); do \
	  cp $(PACKAGE)/$$i $(PACKAGE)-dev/lib/pkgconfig; \
	done

manifest:
	@echo " * Creation of the manifest"
	@cd $(PACKAGE)-bin && find * >> manifest/$(PACKAGE)-bin.mft
	@cd $(PACKAGE)-bin && \
	  echo $(MANIFESTVERBIN) >> manifest/$(PACKAGE)-bin.ver && \
	  echo $(MANIFESTVERDESC) >> manifest/$(PACKAGE)-bin.ver
	@cd $(PACKAGE)-dev && find * >> manifest/$(PACKAGE)-dev.mft
	@cd $(PACKAGE)-dev && \
	  echo $(MANIFESTVERDEV) >> manifest/$(PACKAGE)-dev.ver && \
	  echo $(MANIFESTVERDESC) >> manifest/$(PACKAGE)-dev.ver

archive:
	@echo " * Creation of the archives"
	@tar cf $(PACKAGE)-bin.tar $(PACKAGE)-bin
	@bzip2 -9 $(PACKAGE)-bin.tar
	@tar cf $(PACKAGE)-dev.tar $(PACKAGE)-dev
	@bzip2 -9 $(PACKAGE)-dev.tar

clean:
	@echo " * Cleaning"
	@rm -rf $(PACKAGE)*

help:
	@echo
	@echo "To create the archives, type:"
	@echo " make"
	@echo
	@echo "To remove everything, type:"
	@echo " make clean"
	@echo