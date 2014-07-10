ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)

USEFILE=

# Extra include path for libfreetype and for target overrides and patches
EXTRA_INCVPATH+=$(QNX_TARGET)/usr/include/freetype2 \
	$(QNX_TARGET)/../target-override/usr/include \
	$(PROJECT_ROOT)\zaOS\Core \
	$(PROJECT_ROOT)\zaOS\Screen
#	$(PROJECT_ROOT)\zaOS\Media \
#	C:\bbndk10\oggvorbis\ogg\include \
#	C:\bbndk10\oggvorbis\vorbis\include \
#	C:\bbndk10\mpg123-1.14.4\src
#	C:\bbndk10\ffmpeg-1.0 \ 

EXTRA_SRCVPATH+= $(PROJECT_ROOT)\zaOS\Core \
				 $(PROJECT_ROOT)\zaOS\Screen
#				 $(PROJECT_ROOT)\zaOS\Media 
	
# Extra library search path for target overrides and patches
EXTRA_LIBVPATH+=$(QNX_TARGET)/../target-override/$(CPUVARDIR)/lib \
	$(QNX_TARGET)/../target-override/$(CPUVARDIR)/usr/lib	\
	C:\bbndk10\target_10_0_9_386\qnx6\armle-v7\lib	

# Compiler options for enhanced security and recording the compiler options in release builds
CCFLAGS+=-fstack-protector-all -D_FORTIFY_SOURCE=2 \
	$(if $(filter g so shared,$(VARIANTS)),,-fPIE) \
	$(if $(filter g,$(VARIANTS)),,-frecord-gcc-switches)

# Linker options for enhanced security
LDFLAGS+=-Wl,-z,relro -Wl,-z,now $(if $(filter g so shared,$(VARIANTS)),,-pie)
LDFLAGS+= -lm  -lbps -lstrm -ljpeg  
LDFLAGS+= -lfreetype -lmmrndclient 
LDFLAGS+= -lEGL -lGLESv1_CM -lscreen -lpng 
LDFLAGS+= -lxml2 -lsqlite3 -liconv -lcurl -lfontconfig -lclipboard -lz
#LDFLAGS+= -lz
#LDFLAGS+= -lOpenAL -lalut -lasound
#LDFLAGS+= -logg  -lvorbis -lvorbisfile -lvorbisenc -lmpg123
#LDFLAGS+=  -lavformat  -lavcodec -lavutil

# Add your required library names, here

#LIBS+= m  bps strm jpeg  
#LIBS+= freetype mmrndclient 
#LIBS+= EGL GLESv1_CM screen png 
#LIBS+= xml2 sqlite3 iconv curl fontconfig clipboard  z
#LIBS+= OpenAL alut asound

#LIBPREF_strm = -Bstatic
#LIBPREF_alut = -Bdynamic


include $(MKFILES_ROOT)/qmacros.mk

# Suppress the _g suffix from the debug variant
BUILDNAME=$(IMAGE_PREF_$(BUILD_TYPE))$(NAME)$(IMAGE_SUFF_$(BUILD_TYPE))

include $(MKFILES_ROOT)/qtargets.mk

OPTIMIZE_TYPE_g=none
OPTIMIZE_TYPE=$(OPTIMIZE_TYPE_$(filter g, $(VARIANTS)))