#
# Copyright (C) 2026
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
#

LOCAL_PATH := $(call my-dir)

# com.android.internal.telephony.metrics.TelephonyMetrics was removed in
# Android 17, but the MediaTek ImsService APK shipped in this vendor is built
# against Android 16 and instantiates it from ImsApp.onCreate() ->
# ImsRILAdapter. Without this class the app dies with
#
#   java.lang.ClassNotFoundException:
#       com.android.internal.telephony.metrics.TelephonyMetrics
#       ImsRILAdapter.java:434
#
# at first boot, so it never registers its IMtkRadioEx indication callbacks and
# the RIL keeps logging "mRadioIndicationIms == NULL" while IMS never
# registers. The methods are no-ops - they only ever fed metrics that no longer
# exist. The package itself is still present in A17, so adding the removed
# class back to the boot classpath is safe.
include $(CLEAR_VARS)
LOCAL_MODULE := mediatek-telephony-metrics-stub
LOCAL_SRC_FILES := src/com/android/internal/telephony/metrics/TelephonyMetrics.java
LOCAL_MODULE_TAGS := optional
include $(BUILD_JAVA_BOOT_LIBRARY)
