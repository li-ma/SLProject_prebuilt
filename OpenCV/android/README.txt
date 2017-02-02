How to build OpenCV with Contributions for Android:
    - cd into a directory where you clone opencv and opencv_contrib
    - Clone OpenCV with: git clone https://github.com/opencv/opencv.git
    - Clone OpenCV Contributions with: git clone https://github.com/opencv/opencv_contrib.git
CMAKE GUI
    - Open CMake GUI Application.
      - Set the source code path to the top-level opencv folder
      - Set the build path to .../build (it will create the folder)
      - Set CMAKE_TOOLCHAIN_FILE to the toolchain file found in opencv/platforms/android.
      - Set ANDROID_ABI to arm64-v8a
      - Set WITH_CUDA to off (only when compiling with clang)
      - Type "extra" in the search field to find OPENCV_EXTRA_MODULES_PATH and set it to the opencv_contrib/modules folder
      - Set ANDROID_SDK to your android-sdk location
      - Set ANDROID_NDK to your ndk-bundle location
      - Press Configure
      - Press Generate
CMAKE CLI
    - export ANDROID_SDK=your_sdk_location
    - export ANDROID_NDK=your_ndk_location
    - mkdir build
    - cd build
    - cmake -DCMAKE_TOOLCHAIN_FILE=../opencv/platforms/android/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a -DWITH_CUDA=off -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules ../opencv
    - cmake --build .

- Copy all files from the folder build/lib to SLProject/_lib/prebuilt/OpenCV/android/arm64-v8a
