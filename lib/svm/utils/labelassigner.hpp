#ifndef labelassignerH
#define labelassignerH 

#include <cstdlib>
#include <iostream>
#include <map>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <string>
#include "coordinatedMat.hpp"

using namespace std;
using namespace cv;

vector<char> prepareLabels(coordinatedMat coordMat);

vector<int> convertLabels(vector<char> trainLabels);

#endif


