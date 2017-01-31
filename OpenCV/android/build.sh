#!/bin/sh

usage() {
    echo "Usage: ./build.sh OPENCV_PATH OPENCV_CONTRIB_PATH ANDROID_NDK_PATH ANDROID_ABI"
}

build() {
    cd $1/platforms/android
    mkdir -p $4 && cd $4 

    cmake -DOPENCV_EXTRA_MODULES_PATH=$2/modules \
        -DANDROID_NDK=$3 \
        -DANDROID_NDK_HOST_X64=true \
        -DANDROID_ABI=$4 \
        -DCMAKE_TOOLCHAIN_FILE=../android/android.toolchain.cmake \
        $@ ../..
}

if [ -d "$1" -a -d "$2" -a -d "$3" ]; then
    if [[ "$4" == "" ]]; then
        usage
    fi
    build 
else
    usage
fi
