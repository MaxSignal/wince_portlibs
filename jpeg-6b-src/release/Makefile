# Makefile for creating Windows CE release archives, with the mingw32ce compiler.
# Last updated: 6-Aug-2008

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

VER = 6b
NAME = jpeg
PACKAGE = lib$(NAME)-$(VER)
DEVDIR = $(NAME)-$(VER)
SRCDIR = $(NAME)-$(VER)-src

BIN = jpeg62.dll
LIB = libjpeg.a libjpeg.dll.a ../jpeg-6b/jpeg.def
INCLUDE = ../jpeg-6b/jconfig.h jerror.h jmorecfg.h jpeglib.h

MANIFESTVERBIN = "Jpeg-$(VER): Binary files"
MANIFESTVERDEV = "Jpeg-$(VER): Developer files"
MANIFESTVERDESC = "Libjpeg: JPEG image compression and decompression library"

all: $(NAME)

$(NAME): remove-old copy-src compilation copy manifest archive
	@echo " * Removal of the directories"
	@rm -rf $(DEVDIR)/ $(SRCDIR)/ $(PACKAGE)-bin/ $(PACKAGE)-dev/

remove-old:
	@echo " * Removal of the old files"
	@rm -f $(PACKAGE)-bin*
	@rm -f $(PACKAGE)-dev*

copy-src:
	@echo " * Copy of source files"
	@cp -R ../src/$(DEVDIR) .
	@cp -R ../src/$(SRCDIR) .
	@echo " * Creation of directories and files"
	@mkdir -p $(PACKAGE)-bin/bin
	@mkdir -p $(PACKAGE)-bin/manifest
	@mkdir -p $(PACKAGE)-dev/lib
	@mkdir -p $(PACKAGE)-dev/include
	@mkdir -p $(PACKAGE)-dev/manifest
	@touch $(PACKAGE)-bin/manifest/$(PACKAGE)-bin.mft
	@touch $(PACKAGE)-bin/manifest/$(PACKAGE)-bin.ver
	@touch $(PACKAGE)-dev/manifest/$(PACKAGE)-dev.mft
	@touch $(PACKAGE)-dev/manifest/$(PACKAGE)-dev.ver

compilation:
	@echo " * Compilation of $(PACKAGE)"
	make -C $(SRCDIR)

copy:
	@echo " * Copy of binary and development files"
	@for i in $(BIN); do \
	  cp $(SRCDIR)/$$i $(PACKAGE)-bin/bin; \
	done
	@for i in $(LIB); do \
	  cp $(SRCDIR)/$$i $(PACKAGE)-dev/lib; \
	done
	@for i in $(INCLUDE); do \
	  cp $(SRCDIR)/$$i $(PACKAGE)-dev/include; \
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
	@rm -rf $(DEVDIR)/ $(SRCDIR)/ $(PACKAGE)*

help:
	@echo
	@echo "To create the archives, type:"
	@echo " make"
	@echo
	@echo "To remove everything, type:"
	@echo " make clean"
	@echo