#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2018-2023 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

FDEVICE="ysl"

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export TARGET_ARCH=arm64
    export TW_DEFAULT_LANGUAGE="en"
    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export OF_USE_MAGISKBOOT=1
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
    export FOX_USE_SPECIFIC_MAGlISK_ZIP="~/Magisk.v26.3.zip"
    export OF_NO_MIUI_OTA_VENDOR_BACKUP=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
    export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export FOX_ADVANCED_SECURITY=1
    export OF_SCREEN_H=2160
    export FOX_DELETE_AROMAFM=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_NANO_EDITOR=1
    export FOX_REPLACE_BUSYBOX_PS=1
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export OF_CHECK_OVERWRITE_ATTEMPTS=1
    export OF_USE_GREEN_LED=0
    export OF_ALLOW_DISABLE_NAVBAR=0
    export FOX_ENABLE_APP_MANAGER=1
    export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
    export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export OF_PATCH_AVB20=1

    # Backup partitions
    export OF_QUICK_BACKUP_LIST="/boot;/system_image;/vendor_image;"

    # R12.1 Settings
    export FOX_VERSION="R12.1_1"
    export OF_MAINTAINER="OhMyVenyx"

    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
        export | grep "OF_" >> $FOX_BUILD_LOG_FILE
        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi
