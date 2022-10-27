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

Mat halfProcessImage(Mat image);

Mat preprocessImage(Mat image, bool training);

Mat preprocessImage(Mat image);

Mat preprocessSymbols(Mat image);

#endif

