#!/bin/sh


## Zlib
echo "BUILDING ZLIB..."
cd zlib-1.2.11
make && make install
cd ../

## Expat
echo "BUILDING EXPAT..."
cd expat-2.2.9
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared --disable-sdltest
make && make install
cd ../

## Freetype
echo "BUILDING FREETYPE..."
cd freetype-2.3.7/src/freetype-2.3.7
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared \
            CFLAGS="-O3 -fms-extensions -mms-bitfields -fno-exceptions -fomit-frame-pointer -ffast-math -pipe" \
            CPPFLAGS="-D_WIN32_WCE=0x0420 -DFT_CONFIG_OPTION_SYSTEM_ZLIB -DFT_CONFIG_CONFIG_H=\"<ftconfig.h>\"" \
            LDFLAGS="-Wl,--enable-auto-import -Wl,--force-exe-suffix -Wl,--enable-runtime-pseudo-reloc -Wl,--allow-multiple-definition -Wl,--enable-stdcall-fixup -Wl,-s"
make && make install
cd ../

## Jpeg
echo "BUILDING JPEG..."
cd jpeg-6b-src/src/jpeg-6b-src
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared \
            CFLAGS="-O3 -Wall -mms-bitfields -fno-exceptions -fomit-frame-pointer" \
            CPPFLAGS="-D_WIN32_WCE=0x0400 -D_WIN32_IE=0x0400 -D_LARGEFILE_SOURCE=1 -D_LARGEFILE64_SOURCE=1 -D_FILE_OFFSET_BITS=64 -I../" \
            LDFLAGS="--enable-auto-import -s"
make && make install
cd ../

## Iconv
echo "BUILDING ICONV..."
cd libiconv-1.9.1
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Mad
echo "BUILDING MAD..."
cd libmad-0.15.1b
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Ogg
echo "BUILDING OGG..."
cd libogg-1.3.4
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Png
echo "BUILDING PNG..."
cd libpng-1.2.33/src/libpng-1.2.33
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared \
            CFLAGS="-O3 -mms-bitfields -pipe -fomit-frame-pointer" \
            CPPFLAGS="-DPNG_NO_MMX_CODE -D_WIN32_WCE=0x0420" \
            LDFLAGS="-Wl,--enable-auto-import -Wl,-s"
make && make install
cd ../

## Vorbis
echo "BUILDING VORBIS..."
cd libvorbis-1.3.6
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Pixman
echo "BUILDING PIXMAN..."
cd pixman 
./autogen.sh
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Tremolo
echo "BUILDING TREMOLO..."
cd Tremolo008
make
cd ../

## Tremor
echo "BUILDING TREMOR..."
cd tremor
./autogen.sh
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## SDL
echo "BUILDING SDL..."
cd SDL-1.2
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## SDL_mixer
echo "BUILDING SDL_MIXER..."
cd SDL_mixer
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared \
            --disable-music-midi --disable-music-timidity-midi --disable-music-native-midi --enable-music-ogg-tremor \
            --disable-music-ogg-shared --disable-music-ogg --disable-music-mp3 --disable-music-mp3-shared --disable-smpegtest --enable-music-mad-gpl
make && make install
cd ../

## SDL_image
echo "BUILDING SDL_IMAGE..."
cd SDL_image
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared --disable-png-shared --disable-jpeg-shared
make && make install
cd ../

## SDL_ttf
echo "BUILDING SDL_TTF..."
cd SDL_ttf
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared --disable-sdltest --enable-jpg
make && make install
cd ../

## End
echo "Complete!"