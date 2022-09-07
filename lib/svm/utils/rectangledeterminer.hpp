#ifndef rectangledeterminerH
#define rectangledeterminerH 

#include <cstdlib>
#include <iostream>
#include <map>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <string>
#include "coordinatedMat.hpp"

using namespace std;
using namespace cv;

void showImage(string name, Mat image);

coordinatedMat getBoundingSymbols(Mat changedImage, int area, bool training, bool debugMode, Mat resizedImage);

coordinatedMat getBoundingSymbols(Mat changedImage, int area);

coordinatedMat getBoundingSymbols(Mat changedImage, int area, bool training);

#endif
