cmake_minimum_required(VERSION 3.9) # set CMAKE version
set( CMAKE_CXX_STANDARD 11 ) # set C++ standard to c11
project( OpenCVLearning ) # name of the project
find_package( OpenCV REQUIRED ) # find library in system
include_directories( ${OpenCV_INCLUDE_DIRS} ) # include all library dirs
add_executable( sampletrain sampletrain.cpp ) # executable
target_link_libraries( sampletrain ${OpenCV_LIBS} ) # link OpenCV libraries
add_executable( sampletest sampletest.cpp ) # executable
target_link_libraries( sampletest ${OpenCV_LIBS} ) # link OpenCV libraries
add_executable( realtrain realtrain.cpp ) # executable
target_link_libraries( realtrain ${OpenCV_LIBS} ) # link OpenCV libraries
add_executable( realtest realtest.cpp ) # executable
target_link_libraries( realtest ${OpenCV_LIBS} ) # link OpenCV libraries
add_executable( thresholddeterminer thresholddeterminer.cpp ) # executable
target_link_libraries( thresholddeterminer ${OpenCV_LIBS} ) # link OpenCV libraries

file(COPY "assets/" DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/assets/) # copy assets to build

#MESSAGE( "OpenCV_LIBS: " ${OpenCV_LIBS} ) # simple message to show which OpenCV is used
