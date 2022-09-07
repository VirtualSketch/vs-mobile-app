#ifndef imagepreprocessingH
#define imagepreprocessingH 

#include <cstdlib>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/core/cvdef.h>
#include <opencv2/core/mat.hpp>
#include <string>
#include "rectangledeterminer.hpp"

Size getOptimalSize(Mat image);

Mat halfProcessImage(string imageName);

Mat preprocessImage(string imageName, bool training);

Mat preprocessImage(string imageName);

Mat preprocessSymbols(string imageName);

#endif

