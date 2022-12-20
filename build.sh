#!/bin/sh

## add path to config
export PATH=$PATH:$CEGCC/arm-mingw32ce/bin
export PKG_CONFIG_PATH=$CEGCC/arm-mingw32ce/lib/pkgconfig

## Zlib
echo "BUILDING ZLIB..."
cd zlib-1.2.11
make && make install
cd ../

## Expat
echo "BUILDING EXPAT..."
cd expat-2.2.9
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Freetype
echo "BUILDING FREETYPE..."
cd freetype-2.3.7/src/freetype-2.3.7/builds/unix
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared \
            CC=$CEGCC/bin/arm-mingw32ce-gcc CXX=$CEGCC/bin/arm-mingw32ce-g++ \
            LD=$CEGCC/bin/arm-mingw32ce-ld AR=$CEGCC/bin/arm-mingw32ce-ar \
            RANLIB=$CEGCC/bin/arm-mingw32ce-ranlib STRIP=$CEGCC/bin/arm-mingw32ce-strip \
            WINDRES=$CEGCC/bin/arm-mingw32ce-windres AS=$CEGCC/bin/arm-mingw32ce-as \
            DLLTOOL=$CEGCC/bin/arm-mingw32ce-dlltool OBJDUMP=$CEGCC/bin/arm-mingw32ce-objdump \
            NM=$CEGCC/bin/arm-mingw32ce-nm \
            CFLAGS="-O3 -fms-extensions -mms-bitfields -fno-exceptions -fomit-frame-pointer -ffast-math -pipe" \
            CPPFLAGS="-D_WIN32_WCE=0x0420 -DFT_CONFIG_OPTION_SYSTEM_ZLIB -DFT_CONFIG_CONFIG_H=\"<ftconfig.h>\"" \
            LDFLAGS="-Wl,--enable-auto-import -Wl,--force-exe-suffix -Wl,--enable-runtime-pseudo-reloc -Wl,--allow-multiple-definition -Wl,--enable-stdcall-fixup -Wl,-s"
cd ../../
mkdir objs
make && make install
cd ../../../

## Jpeg
echo "BUILDING JPEG..."
cd jpeg-6b-src/src/jpeg-6b-src
make && make install
cd ../../../

## Mad
echo "BUILDING MAD..."
cd libmad-0.15.1b
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Ogg
echo "BUILDING OGG..."
cd libogg-1.3.4
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Png
echo "BUILDING PNG..."
cd libpng-1.2.33/src/libpng-1.2.33
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared \
            CFLAGS="-O3 -mms-bitfields -pipe -fomit-frame-pointer" \
            CPPFLAGS="-DPNG_NO_MMX_CODE -D_WIN32_WCE=0x0420" \
            LDFLAGS="-Wl,--enable-auto-import -Wl,-s"
make && make install
cd ../../../

## Vorbis
echo "BUILDING VORBIS..."
cd libvorbis-1.3.6
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## Pixman
echo "BUILDING PIXMAN..."
cd pixman 
chmod +x autogen.sh
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
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## SDL
echo "BUILDING SDL..."
cd SDL-1.2
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared
make && make install
cd ../

## SDL_mixer
echo "BUILDING SDL_MIXER..."
cd SDL_mixer
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared \
            --disable-music-midi --disable-music-timidity-midi --disable-music-native-midi --enable-music-ogg-tremor \
            --disable-music-ogg-shared --disable-music-ogg --disable-music-mp3 --disable-music-mp3-shared --disable-smpegtest --enable-music-mad-gpl
make && make install
cd ../

## SDL_image
echo "BUILDING SDL_IMAGE..."
cd SDL_image
chmod +x configure
./autogen.sh 
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared --disable-sdltest --enable-jpg-shared=no \
            --enable-png-shared=no --enable-tif-shared=no --enable-tif=no LIBJPEG_CFLAGS="-I$CEGCC/arm-mingw32ce/include" LIBJPEG_LIBS="$CEGCC/arm-mingw32ce/lib/libjpeg.a"
make && make install 
cat Makefile
cd ../

## SDL_ttf
echo "BUILDING SDL_TTF..."
cd SDL_ttf
chmod +x configure
./configure --prefix=$CEGCC/arm-mingw32ce --host=arm-mingw32ce --target=arm-mingw32ce --disable-shared --disable-sdltest --enable-jpg
make && make install
cd ../

## End
echo "Complete!"