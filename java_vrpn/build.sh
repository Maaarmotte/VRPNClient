#!/bin/bash

# This script will build Java VRPN libraries for Android
# Output will be in ../vrpn/build/ directory

# Be sure to go in the right directory
cd ~/vrpn/java_vrpn/

# To build java_vrpn libraries, you need:
# - Android SDK
# - Android NDK
# - Android CMake (http://code.google.com/p/android-cmake)
# - Android toolchain (https://github.com/taka-no-me/android-cmake, extract in android-cmake/toolchain folder)

export ANDROID_SDK=$HOME/android-sdk-linux
export ANDROID_NDK=$HOME/android-ndk-r10d
export NDK=$HOME/android-ndk-r10d
export ANDROID_CMAKE=$HOME/android-cmake
export ANDROID_NDK_TOOLCHAIN_ROOT=$HOME/android-toolchain

# Sometimes, CMake can't find java... You may have to set the variables manually
JAVA_AWT_LIBRARY=/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64
JAVA_JVM_LIBRARY=/usr/lib/jvm/java-7-openjdk-amd64/lib

bash make_header.sh

$ANDROID_NDK/build/tools/make-standalone-toolchain.sh --platform=android-19 --install-dir=$HOME/android-toolchain --arch=arm

cd ..
mkdir build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_CMAKE/toolchain/android.toolchain.cmake .. -DVRPN_BUILD_JAVA=1 -DVRPN_BUILD_SERVER_LIBRARY=1 -DCMAKE_CXX_FLAGS=-fpermissive -DVRPN_BUILD_CLIENT_LIBRARY=1 \
-DJAVA_AWT_LIBRARY:STRING=$JAVA_AWT_LIBRARY -DJAVA_JVM_LIBRARY:STRING=$JAVA_JVM_LIBRARY

make
