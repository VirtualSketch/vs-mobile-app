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

/*
 * Deskewing the numbers and symbols to better determine
 * its features and keeping a pattern between them.
 */

Mat deskew(Mat &img) {

    Moments m = moments(img);

    if (abs(m.mu02) < 1e-2)
        return img.clone();

    float skew = m.mu11 / m.mu02;

    Mat warpMat = (Mat_<float>(2, 3) << 1, skew, -0.5 * 20 * skew, 0, 1, 0);

    Mat imgOut = Mat::zeros(img.rows, img.cols, img.type());

    warpAffine(img, imgOut, warpMat, imgOut.size(), WARP_INVERSE_MAP | INTER_LINEAR);

    return imgOut;
}

/*
 * Transforming a vector of feature descriptors into a Mat.
 */

Mat getHogDescriptorsMat(vector<vector<float>> hogDescriptors) {

    int descriptorSize = hogDescriptors.at(0).size();

    Mat hogMat(hogDescriptors.size(), descriptorSize, CV_32FC1);

    for (int i = 0; i < hogDescriptors.size(); i++) {
        for (int j = 0; j < descriptorSize; j++) {
            hogMat.at<float>(i, j) = hogDescriptors[i][j];
        }
    }

    return hogMat;
}

/*
 * Determining the feature descriptors for each deskewed symbol
 * in the given coordinatedMat structure.
 */

vector<vector<float>> determineHogDescriptors(HOGDescriptor hog, coordinatedMat coordMat) {

    vector<vector<float>> hogDescriptors;

    for (int i = 0; i < coordMat.numbers.size(); i++) {
        Mat currentNum = coordMat.numbers.at(i);

        resize(currentNum, currentNum, Size(40, 40));

        currentNum = deskew(currentNum);

        vector<float> currentNumDescriptors;

        /* imshow(to_string(currentNum.cols) + ", " + to_string(currentNum.rows), currentNum); */
        /* waitKey(0); */
        /* destroyAllWindows(); */

        hog.compute(currentNum, currentNumDescriptors);

        hogDescriptors.push_back(currentNumDescriptors);
    }

    return hogDescriptors;
}
