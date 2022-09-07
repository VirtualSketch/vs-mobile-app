#ifndef descriptordeterminerH
#define descriptordeterminerH

#include <opencv2/core/mat.hpp>
#include <opencv2/objdetect.hpp>
#include "coordinatedMat.hpp"

using namespace cv;
using namespace std;

Mat deskew(Mat &img);

Mat getHogDescriptorsMat(vector<vector<float>> hogDescriptors);

vector<vector<float>> determineHogDescriptors(HOGDescriptor hog, coordinatedMat coordMat);

#endif
