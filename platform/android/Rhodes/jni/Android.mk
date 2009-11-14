LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

RHO_SHARED_PATH := $(LOCAL_PATH)/../../../shared
STLPORT_BASE    := $(RHO_SHARED_PATH)/stlport
RHO_BIN_PATH    := $(shell grep -P '^\s*app:' $(LOCAL_PATH)/../../../../rhobuild.yml | sed 's/^\s*app:\s*//')/bin

LOCAL_MODULE    := rhodes

LOCAL_SRC_FILES := \
	src/rhodes.cpp \
	src/logconf.cpp \
	src/callbacks.cpp \
	src/webview.cpp \
	src/geolocation.cpp \
	src/mapview.cpp \
	src/alert.cpp \
	src/camera.cpp \
	src/datetimepicker.cpp \
	src/nativebar.cpp \
	src/phonebook.cpp \
	src/syncengine.cpp \
	src/RhoClassFactory.cpp

LOCAL_CFLAGS += \
	-I$(STLPORT_BASE)/stlport \
	-I$(LOCAL_PATH)/include \
	-I$(RHO_SHARED_PATH) \
	-I$(RHO_SHARED_PATH)/sqlite \
	-I$(RHO_SHARED_PATH)/curl/include \
	-I$(RHO_SHARED_PATH)/ruby/include \
	-I$(RHO_SHARED_PATH)/ruby/linux \
	-D__NEW__ \
	-D__SGI_STL_INTERNAL_PAIR_H \
	-DANDROID -DOS_ANDROID \
	-D_DEBUG \
	-g -O0

LOCAL_LDLIBS += \
	-L$(STLPORT_BASE)/build/lib/obj/arm-linux-gcc/so \
	-L$(RHO_BIN_PATH)/libs \
	-lrhomain -lshttpd -lruby -lrhosync -lrhodb \
	-lrholog -lrhocommon -ljson -lstlport -lcurl -lsqlite \
	-ldl -lz

LOCAL_ARM_MODE  := arm

include $(BUILD_SHARED_LIBRARY)