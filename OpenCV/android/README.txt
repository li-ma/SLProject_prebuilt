How to build OpenCV with Contributions for Android:

ATTENTION: NDK version r16b does not work with cmake-android. Manually install NDK version r15c (location: "C:\Users\<USER_NAME>\AppData\Local\Android\Sdk\ndk-bundle")
https://developer.android.com/ndk/downloads/index.html

general hints:
- cd into a directory where you clone opencv and opencv_contrib
- Clone OpenCV with: git clone https://github.com/opencv/opencv.git
- Clone OpenCV Contributions with: git clone https://github.com/opencv/opencv_contrib.git
	
FFMPEG integration (needed for playing video files on android):
- you find prebuild ffmpeg binaries in folder ffmpeg beside this readme
- copy folders arm64-v8a and armeabi-v7a of prebuild ffmpeg binaries to <OPENCV_FOLDER>/opencv/3rdparty/ffmpeg/android
- manually edit CMakeLists.txt in opencv's root directory (opencv) as in CMakeLists.txt.diff. replace lines prefixed by "-" with lines prefixed by  "+" (file lies beside this readme).
- manually edit OpenCVFindLibsVideo.cmake due to changes in OpenCVFindLibsVideo.cmake.diff accordingly(file lies beside this readme).
- in the following cmake build process, make sure you define cmake variable WITH_FFMPEG=true
- after the opencv build process, remember to copy ffmpeg libraries to your distribution folder

OpenCV build on Linux (Windows see below):

CMAKE GUI
    - Open CMake GUI Application.
      - Set the source code path to the top-level opencv folder
      - Set the build path to .../build (it will create the folder). If the folder already exists, delete all content (esp. if configuratio has changes significantly)
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


OpenCV build on Windows:
	references:
	https://zami0xzami.wordpress.com/2016/03/16/building-opencv-using-mingw-on-windows/
	https://zami0xzami.wordpress.com/2016/03/16/building-java-wrapper-for-opencv/

prerequisites:
	-install cmake
	-install minGW
	
	- Java and Ant are necessary if you want to build all opencv modules in one big shared object file (libopencv_java3.so). In this case set cmake variable BUILD_SHARD_LIBS=false. You will get many individual static libaries (*.a) for every opencv module and one big libopencv_java3.so shared library containing all modules. You can use the one libopencv_java3.so for dynamic linking or the single static libs for static linking. If you prefer single dynamic library files set BUILD_SHARD_LIBS=true.
		-download and install python 2.6+
		-install jdk 6+
			-Set JAVA_HOME environment variable. 
			-Add the JAVA_HOME/bin directory to your PATH	environment variable.
		-install Ant (http://ant.apache.org/bindownload.cgi)
			-Add the bin directory to your PATH	environment variable.
			-Add the ANT_HOME environment variable point to Ant root folder.
	
CMAKE GUI
    - Open CMake GUI Application.
      - Set the source code path to the top-level opencv folder
      - Set the build path to .../build (it will create the folder). If the folder already exists, delete all content (esp. if configuratio has changes significantly).
	  - press "Configure" button
	  - select "MinGW Makefiles" and radio button "Specify toolchain file for cross-compiling".
	  - press "Next"
	  - select toolchain file "<opencv_folder>/opencv/platforms/android/android.toolchain.cmake"
	  - press "Finish" (you will get errors)
	  - Add variable ANDROID_NDK and point it to your ndk (normally in "C:\Users\<USER_NAME>\AppData\Local\Android\Sdk\ndk-bundle")
	  - if not found automatically, specify CMAKE_MAKE_PROGRAM filepath to find mingw32-make.exe (e.g. "C:/MinGW/bin/mingw32-make.exe")
	  - press "Configure"
	  - customize configuration:
		- ANDROID_ABI=arm64-v8a (or armeabi-v7a, remember to delete all files in build directory, when you change this later)
		- OPENCV_EXTRA_MODULES_PATH=<opencv_folder>/opencv_contrib/modules
		- WITH_CUDA=off (always off)
		- WITH_FFMPEG=true
		- CMAKE_INSTALL_PREFIX=<opencv_folder>/install
	  - press "Configure"
	  - press "Generate"
	
CMAKE CLI
	-open mingw cli
	-navigate to opencv build directory
	-execute following cmake script. (ATTENTION: don't forget to edit CMAKE_MAKE_PROGRAM and ANDROID_ABI according to your configuration)
	cmake -G"MinGW Makefiles" -DCMAKE_MAKE_PROGRAM="C:/MinGW/bin/mingw32-make.exe" -DCMAKE_TOOLCHAIN_FILE=../opencv/platforms/android/android.toolchain.cmake -DANDROID_NDK="C:\Users\ghm1\AppData\Local\Android\Sdk\ndk-bundle" -DANDROID_ABI=armeabi-v7a -DANDROID_NDK_HOST_X64=true -DWITH_CUDA=off -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules -DWITH_FFMPEG=true -DCMAKE_INSTALL_PREFIX=D:/Development/opencv.3.4/install ../opencv
	-run make and install files:
	mingw32-make
	mingw32-make install





