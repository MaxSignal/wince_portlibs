# Makefile for libjpeg using cegcc.

# Copyright (C) 2008 V. Torri.

# To compile, type:
#
#   make
#
# To install, type:
#
#   make install

prefix = $(CEGCC)
BIN_PATH = $(CEGCC)/bin
INCLUDE_PATH = $(CEGCC)/include
LIBRARY_PATH = $(CEGCC)/lib

STATICLIB = libjpeg.a
SHAREDLIB = jpeg62.dll
IMPLIB    = libjpeg.dll.a

EXE =

TARGET = arm-mingw32ce

CC = $(TARGET)-gcc$(EXE)
CPPFLAGS = -D_WIN32_WCE=0x0400 -D_WIN32_IE=0x0400 -D_LARGEFILE_SOURCE=1 -D_LARGEFILE64_SOURCE=1 -D_FILE_OFFSET_BITS=64 -I../jpeg-6b
CFLAGS = -O3 -Wall -mms-bitfields -fno-exceptions -fomit-frame-pointer 

LD = $(CC)
LDFLAGS = -Wl,--enable-auto-import -Wl,-s

AR = $(TARGET)-ar$(EXE)
ARFLAGS = rcs

RC = $(TARGET)-windres$(EXE)
RCFLAGS = --define GCC_WINDRES

DLLTOOL = $(TARGET)-dlltool$(EXE)

# Put here the object file name for the correct system-dependent memory
# manager file.  For Unix this is usually jmemnobs.o, but you may want
# to use jmemansi.o or jmemname.o if you have limited swap space.
SYSDEPMEM= jmemnobs.o

# library object files common to compression and decompression
COMOBJECTS= jcomapi.o jutils.o jerror.o jmemmgr.o $(SYSDEPMEM)
# compression library object files
CLIBOBJECTS= jcapimin.o jcapistd.o jctrans.o jcparam.o \
        jdatadst.o jcinit.o jcmaster.o jcmarker.o jcmainct.o \
        jcprepct.o jccoefct.o jccolor.o jcsample.o jchuff.o \
        jcphuff.o jcdctmgr.o jfdctfst.o jfdctflt.o \
        jfdctint.o
# decompression library object files
DLIBOBJECTS= jdapimin.o jdapistd.o jdtrans.o jdatasrc.o \
        jdmaster.o jdinput.o jdmarker.o jdhuff.o jdphuff.o \
        jdmainct.o jdcoefct.o jdpostct.o jddctmgr.o \
        jidctfst.o jidctflt.o jidctint.o jidctred.o \
        jdsample.o jdcolor.o jquant1.o jquant2.o jdmerge.o
# These objectfiles are included in libjpeg.a
OBJS= $(CLIBOBJECTS) $(DLIBOBJECTS) $(COMOBJECTS)
DLL_OBJS= $(OBJS) ../jpeg-6b/res/jpeg-dllversion.o

all: clean $(STATICLIB)

.c.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(STATICLIB): $(OBJS)
	$(AR) $(ARFLAGS) $@ $(OBJS) $(OBJA)

$(IMPLIB): $(SHAREDLIB)

$(SHAREDLIB): ../jpeg-6b/jpeg.def $(DLL_OBJS)
	$(DLLTOOL) --def ../jpeg-6b/jpeg.def --dllname=$(SHAREDLIB) --output-lib $(IMPLIB)
	$(CC) -DJPEG_DLL -shared -o $@ \
	-Wl,-s \
	-Wl,--out-implib=$(IMPLIB) \
	-Wl,--export-all-symbols \
	-Wl,--enable-auto-import \
	$(DLL_OBJS)


# INCLUDE_PATH and LIBRARY_PATH must be set.

.PHONY: install uninstall clean

install: ../jpeg-6b/jconfig.h jerror.h jmorecfg.h jpeglib.h $(STATICLIB)
	-$(INSTALL) ../jpeg-6b/jconfig.h $(INCLUDE_PATH)
	-$(INSTALL) ./jerror.h $(INCLUDE_PATH)
	-$(INSTALL) ./jmorecfg.h $(INCLUDE_PATH)
	-$(INSTALL) ./jpeglib.h $(INCLUDE_PATH)
	-$(INSTALL) ./$(STATICLIB) $(LIBRARY_PATH)
	
# -$(INSTALL) $(IMPLIB) $(LIBRARY_PATH)
# -$(INSTALL) $(SHAREDLIB) $(BIN_PATH)

uninstall:
	-$(RM) $(INCLUDE_PATH)/jconfig.h
	-$(RM) $(INCLUDE_PATH)/jerror.h
	-$(RM) $(INCLUDE_PATH)/jmorecfg.h
	-$(RM) $(INCLUDE_PATH)/jpeglib.h
	-$(RM) $(LIBRARY_PATH)/jpeg.def
	-$(RM) $(LIBRARY_PATH)/$(STATICLIB)
# -$(RM) $(LIBRARY_PATH)/$(IMPLIB)
# -$(RM) $(BIN_PATH)/$(SHAREDLIB)

clean:
	-$(RM) $(STATICLIB)
	-$(RM) $(SHAREDLIB)
	-$(RM) $(IMPLIB)
	-$(RM) *.o
	-$(RM) ../jpeg-6b/res/*.o
