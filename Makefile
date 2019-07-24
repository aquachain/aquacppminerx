ifndef config
  #config=debug_x64
  config=rel_x64
endif

ifndef verbose
  SILENT = @
endif

ifeq ($(config),debug_x64)
  aquacppminer_config = debug_x64
endif
ifeq ($(config),debug_win32)
  aquacppminer_config = debug_win32
endif
ifeq ($(config),debug_linux32)
  aquacppminer_config = debug_linux32
endif
ifeq ($(config),rel_x64)
  aquacppminer_config = rel_x64
endif
ifeq ($(config),rel_win32)
  aquacppminer_config = rel_win32
endif
ifeq ($(config),rel_linux32)
  aquacppminer_config = rel_linux32
endif
ifeq ($(config),relavx_x64)
  aquacppminer_config = relavx_x64
endif
ifeq ($(config),relavx_win32)
  aquacppminer_config = relavx_win32
endif
ifeq ($(config),relavx_linux32)
  aquacppminer_config = relavx_linux32
endif
ifeq ($(config),relavx2_x64)
  aquacppminer_config = relavx2_x64
endif
ifeq ($(config),relavx2_win32)
  aquacppminer_config = relavx2_win32
endif
ifeq ($(config),relavx2_linux32)
  aquacppminer_config = relavx2_linux32
endif

.PHONY: all clean help


#aquacppminer:
#ifneq (,$(aquacppminer_config))
#	@echo "==== Building aquacppminer ($(aquacppminer_config)) ===="
#	@${MAKE} --no-print-directory config=$(aquacppminer_config)
#
#endif

TARGETDIR ?= bin

aquacppminer: $(TARGETDIR)/aquacppminer # normal
aquacppminer_d: $(TARGETDIR)/aquacppminer_d # slow, debug
aquacppminer_avx: $(TARGETDIR)/aquacppminer_avx # avx support
aquacppminer_avx2: $(TARGETDIR)/aquacppminer_avx2 # avx2 support!

help:
	@echo "Usage: make [config=name] [target]"
	@echo ""
	@echo "CONFIGURATIONS:"
	@echo "  debug_x64"
	@echo "  debug_win32"
	@echo "  debug_linux32"
	@echo "  rel_x64"
	@echo "  rel_win32"
	@echo "  rel_linux32"
	@echo "  relavx_x64"
	@echo "  relavx_win32"
	@echo "  relavx_linux32"
	@echo "  relavx2_x64"
	@echo "  relavx2_win32"
	@echo "  relavx2_linux32"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   aquacppminer"
	@echo ""
ifndef config
  config=rel_x64
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild prelink

ifeq ($(config),debug_x64)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_d
  OBJDIR = obj/x64/Debug
  DEFINES += -DARCH=\"Linux64\" -D_DEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -g
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -g -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),debug_win32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_d
  OBJDIR = obj/win32/Debug
  DEFINES += -D_DEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -g
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -g -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),debug_linux32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_d
  OBJDIR = obj/linux32/Debug
  DEFINES += -DARCH=\"Linux32\" -D_DEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -g -msse3
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -g -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -msse3
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),rel_x64)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer
  OBJDIR = obj/x64/Rel
  DEFINES += -DARCH=\"Linux64\" -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -O3
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),rel_win32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer
  OBJDIR = obj/win32/Rel
  DEFINES += -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -O3
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),rel_linux32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer
  OBJDIR = obj/linux32/Rel
  DEFINES += -DARCH=\"Linux32\" -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -O3 -msse3
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -msse3
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),relavx_x64)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_avx
  OBJDIR = obj/x64/RelAVX
  DEFINES += -DARCH=\"Linux64\" -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -O3 -mavx
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -mavx
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),relavx_win32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_avx
  OBJDIR = obj/win32/RelAVX
  DEFINES += -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -O3 -mavx
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -mavx
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),relavx_linux32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_avx
  OBJDIR = obj/linux32/RelAVX
  DEFINES += -DARCH=\"Linux32\" -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -O3 -mavx -msse3
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -mavx -msse3
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),relavx2_x64)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_avx2
  OBJDIR = obj/x64/RelAVX2
  DEFINES += -DARCH=\"Linux64\" -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -O3 -mavx2
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -mavx2
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),relavx2_win32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_avx2
  OBJDIR = obj/win32/RelAVX2
  DEFINES += -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -O3 -mavx2
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -mavx2
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),relavx2_linux32)
  RESCOMP = windres
  TARGET = $(TARGETDIR)/aquacppminer_avx2
  OBJDIR = obj/linux32/RelAVX2
  DEFINES += -DARCH=\"Linux32\" -DNDEBUG -D_CRT_SECURE_NO_WARNINGS -D_CONSOLE -D_HAS_EXCEPTIONS=0 -DARGON2_NO_THREADS -DARGON2_NO_SECURE_WIPE
  INCLUDES += -Isrc -Ivendored/phc-winner-argon2/include -Ivendored/rapidjson/include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -O3 -mavx2 -msse3
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -fomit-frame-pointer -ffast-math -O3 -std=c++11 -fno-exceptions -fno-stack-protector -fno-rtti -mavx2 -msse3
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -s -lgmp -lpthread -lcrypto `curl-config --libs`
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:
endif

OBJECTS := \
	$(OBJDIR)/blake2b.o \
	$(OBJDIR)/argon2.o \
	$(OBJDIR)/blake2b1.o \
	$(OBJDIR)/core.o \
	$(OBJDIR)/encoding.o \
	$(OBJDIR)/opt.o \
	$(OBJDIR)/thread.o \
	$(OBJDIR)/args.o \
	$(OBJDIR)/config.o \
	$(OBJDIR)/formatDuration.o \
	$(OBJDIR)/getPwd.o \
	$(OBJDIR)/hex_encode_utils.o \
	$(OBJDIR)/http.o \
	$(OBJDIR)/kbhit.o \
	$(OBJDIR)/log.o \
	$(OBJDIR)/main.o \
	$(OBJDIR)/miner.o \
	$(OBJDIR)/miningConfig.o \
	$(OBJDIR)/string_utils.o \
	$(OBJDIR)/tests.o \
	$(OBJDIR)/timer.o \
	$(OBJDIR)/updateThread.o \

RESOURCES := \

CUSTOMFILES := \

SHELLTYPE := msdos
ifeq (,$(ComSpec)$(COMSPEC))
  SHELLTYPE := posix
endif
ifeq (/bin,$(findstring /bin,$(SHELL)))
  SHELLTYPE := posix
endif

$(TARGET): $(GCH) ${CUSTOMFILES} $(OBJECTS) $(LDDEPS) $(RESOURCES)
	@echo Linking $(TARGET)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

clean:
	@echo Cleaning aquacppminer
ifeq (posix,$(SHELLTYPE))
	rm -f $(TARGET)
	rmdir $(TARGETDIR) 2>>/dev/null || true
	rm -rf $(OBJDIR)
	rmdir -p $(OBJDIR) 2>>/dev/null || true
	rmdir -p obj 2>>/dev/null || true
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(OBJECTS): $(GCH) $(PCH)
$(GCH): $(PCH)
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) -x c++-header $(ALL_CXXFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
endif

$(OBJDIR)/blake2b.o: vendored/blake2/sse/blake2b.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/argon2.o: vendored/phc-winner-argon2/src/argon2.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/blake2b1.o: vendored/phc-winner-argon2/src/blake2/blake2b.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/core.o: vendored/phc-winner-argon2/src/core.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/encoding.o: vendored/phc-winner-argon2/src/encoding.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/opt.o: vendored/phc-winner-argon2/src/opt.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/thread.o: vendored/phc-winner-argon2/src/thread.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/args.o: src/args.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/config.o: src/config.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/formatDuration.o: src/formatDuration.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/getPwd.o: src/getPwd.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/hex_encode_utils.o: src/hex_encode_utils.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/http.o: src/http.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/kbhit.o: src/kbhit.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/log.o: src/log.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/main.o: src/main.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/miner.o: src/miner.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/miningConfig.o: src/miningConfig.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/string_utils.o: src/string_utils.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/tests.o: src/tests.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/timer.o: src/timer.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/updateThread.o: src/updateThread.cpp
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
endif
