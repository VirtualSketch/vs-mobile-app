cmake_minimum_required(VERSION 3.9) # set CMAKE version
set( CMAKE_CXX_STANDARD 11 ) # set C++ standard to c11
set( ANDROID_OPENCV_SOURCE_DIR /home/atikin/Downloads/opencv-android/OpenCV-android-sdk/sdk/native/jni/include )
project( vs-ai-vision ) # name of the project
include_directories( ${ANDROID_OPENCV_SOURCE_DIR} ) # include all library dirs

add_library(
    lib_opencv
    SHARED
    IMPORTED
)

set_target_properties(
    lib_opencv
    PROPERTIES
    IMPORTED_LOCATION 
    ${CMAKE_CURRENT_SOURCE_DIR}/../../android/app/src/main/jniLibs/${ANDROID_ABI}/libopencv_java4.so
)

add_library(
    svmutils
    SHARED
    train.cpp
    predict.cpp
    utils/coordinatedMat.hpp
    utils/svm.cpp
    utils/labelassigner.cpp
    utils/descriptordeterminer.cpp
    utils/rectangledeterminer.cpp
    utils/imagepreprocessing.cpp
)

# target_link_libraries(svmutils ${OpenCV_LIBS} cv_core-lib cv_highgui-lib cv_imgproc-lib cv_objdetect-lib cv_ml-lib)
target_link_libraries(svmutils lib_opencv)

file(COPY "assets/" DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/assets/) # copy assets to build

#MESSAGE( "OpenCV_LIBS: " ${OpenCV_LIBS} ) # simple message to show which OpenCV is used
