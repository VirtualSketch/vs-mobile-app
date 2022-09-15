#ifndef coordinatedMatH
#define coordinatedMatH

#include <iostream>
#include <vector>
#include <opencv2/core/mat.hpp>

/*
 * coordinatedMat is a data structure for holding
 * all of the detected numbers as Mat with their coordinates
 * for a clearer definition of features.
 */

struct coordinatedMat {
    std::vector<cv::Mat> numbers;
    std::vector<int> numbersX; 
    std::vector<int> numbersY;
};

#endif
