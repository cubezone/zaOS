ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)

USEFILE=

# Extra include path for libfreetype and for target overrides and patches
EXTRA_INCVPATH+=$(QNX_TARGET)/usr/include/freetype2 \
	$(QNX_TARGET)/../target-override/usr/include \
	$(QNX_TARGET)/usr/include/qt4 \
	$(QNX_TARGET)/usr/include/qt4/QtCore \
	$(QNX_TARGET)/usr/include/bb/system 

# Extra library search path for target overrides and patches
EXTRA_LIBVPATH+=$(QNX_TARGET)/../target-override/$(CPUVARDIR)/lib \
	$(QNX_TARGET)/../target-override/$(CPUVARDIR)/usr/lib \
	$(QNX_TARGET)/../target-override/$(CPUVARDIR)/usr/lib/qt4 \
	"C:\bbndk10\target_10_0_9_386\qnx6\armle-v7\usr\lib\qt4\lib" 

# Compiler options for enhanced security and recording the compiler options in release builds
CCFLAGS+=-fstack-protector-all -D_FORTIFY_SOURCE=2 \
	-DQT_BOOTSTRAPPED \
	$(if $(filter g so shared,$(VARIANTS)),,-fPIE) \
	$(if $(filter g,$(VARIANTS)),,-frecord-gcc-switches)

# Linker options for enhanced security
LDFLAGS+= -Wl,-z,relro -Wl,-z,now $(if $(filter g so shared,$(VARIANTS)),,-pie)
LDFLAGS+= -lm  -lbps -lstrm -ljpeg  
LDFLAGS+= -lfreetype -lmmrndclient 
LDFLAGS+= -lEGL -lGLESv1_CM -lscreen -lpng  -lz
LDFLAGS+= -lxml2 -lsqlite3 -liconv -lcurl -lfontconfig -lclipboard
LDFLAGS+= -lbbsystem -lQtCore -lbbdevice -lbbplatform -lbbdata
#LDFLAGS+= -lbbpim -limg
#LDFLAGS+= -lOpenAL -lalut -lasound 
#LDFLAGS+= -logg  -lvorbis -lvorbisfile -lvorbisenc -lmpg123 

# Add your required library names, here
LIBS+= 
#bbsystem

include $(MKFILES_ROOT)/qmacros.mk


# Suppress the _g suffix from the debug variant
BUILDNAME=$(IMAGE_PREF_$(BUILD_TYPE))$(NAME)$(IMAGE_SUFF_$(BUILD_TYPE))

include $(MKFILES_ROOT)/qtargets.mk

OPTIMIZE_TYPE_g=none
OPTIMIZE_TYPE=$(OPTIMIZE_TYPE_$(filter g, $(VARIANTS)))
