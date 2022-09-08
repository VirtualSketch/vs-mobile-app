# virtual_sketch_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## C++ requirements

To build this project, the official Android OpenCV SDK is required, and can be downloaded here:

- [OpenCV official releases](https://opencv.org/releases/)

Download the latest Android version and uncompress the files.

Then, create a symbolic link at /android/app/src/main/jniLibs that points to /path/to/OpenCV-android-sdk/sdk/native/libs, so it stays like this:

    android
    └── app
        └── src
            └── main
                └── jniLibs -> /path/to/OpenCV-android-sdk/sdk/native/libs

Finally, change the file android/app/build.gradle and find the -DANDROID_OPENCV_SOURCE_DIR argument and assign the value of /path/to/OpenCV-android-sdk/sdk/native/jni/include to it.

        defaultConfig {
            ...
            externalNativeBuild {
                cmake {
                      cppFlags '-frtti -fexceptions -std=c++11'
                      arguments "-DANDROID_STL=c++_shared",
                          "-DANDROID_OPENCV_SOURCE_DIR=/path/to/OpenCV-android-sdk/sdk/native/jni/include"
                }
            }
        }

This is so CMakeLists.txt can include the OpenCV libs for Android compilation.
