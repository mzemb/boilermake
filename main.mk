# expected to be repo root
TOP_PATH := ${PWD}

# boilermake paths configuration
BUILD_DIR  := build
TARGET_DIR := target

# git clone --depth 1 https://github.com/raspberrypi/tools.git rpiTools
RPI_TOOLKIT:=/opt/rpiTools

# raspberry build options
RPI_GCC_PATH := $(RPI_TOOLKIT)/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64
RPI_LIB_PATH := $(RPI_TOOLKIT)/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/arm-linux-gnueabihf
RPI_CC       := $(RPI_GCC_PATH)/bin/arm-linux-gnueabihf-gcc
RPI_CXX      := $(RPI_GCC_PATH)/bin/arm-linux-gnueabihf-c++
RPI_LINKER   := $(RPI_GCC_PATH)/bin/arm-linux-gnueabihf-c++
RPI_STRIP     = $(RPI_GCC_PATH)/bin/arm-linux-gnueabihf-strip target/$(TARGET) # '=' and not ':=' , TARGET should be evaluated later
RPI_CFLAGS   := -Wall -Werror -Wextra
RPI_LDFLAGS  := -lpthread -lrt
RPI_LDLIBS   := \
	-L$(RPI_LIB_PATH)/lib                              \
	-L$(RPI_LIB_PATH)/libc/usr/lib/arm-linux-gnueabihf
define RPI_DEF
TGT_CC      := $(RPI_CXX)
TGT_CXX     := $(RPI_CXX)
TGT_LINKER  := $(RPI_LINKER)
TGT_LDFLAGS := $(RPI_LDFLAGS)
TGT_LDLIBS  := $(RPI_LDLIBS)
TGT_POSTMAKE:= $(RPI_STRIP)
TGT_CFLAGS  := $(RPI_CFLAGS)
SRC_INCDIRS := $(TOP_PATH)
endef

# x64 build options
X64_CC       := /usr/bin/gcc
X64_CXX      := /usr/bin/g++
X64_LINKER   := /usr/bin/g++
X64_STRIP    := /usr/bin/strip
X64_CFLAGS   := -Wall -Werror -Wextra
X64_LDFLAGS  := -lpthread -lrt
X64_LDLIBS   := -L/usr/lib
define X64_DEF
TGT_CC      := $(X64_CXX)
TGT_CXX     := $(X64_CXX)
TGT_LINKER  := $(X64_LINKER)
TGT_LDFLAGS := $(X64_LDFLAGS)
TGT_LDLIBS  := $(X64_LDLIBS)
TGT_CFLAGS  := $(X64_CFLAGS)
SRC_INCDIRS := $(TOP_PATH)
endef

# list submakefiles: all modules to be included in this top level makefile
SUBMAKEFILES :=      \
	src/hello.rpi.mk \
	src/hello.mk 

