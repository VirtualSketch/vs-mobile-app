#include <cstdlib>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/core/cvdef.h>
#include <opencv2/core/mat.hpp>
#include <string>
#include "rectangledeterminer.hpp"

using namespace std;
using namespace cv;

/*
 * Function that returns the best size for resizing the image.
 * For instance, if the image has 1249x747 pixels, our optimal size
 * would be 1200x700 for best results
 */

Size getOptimalSize(Mat image) {

    string height = to_string(image.rows);
    string width = to_string(image.cols);

    for (int i = height.length(); i <= 4; i++) {
        height = "0" + height;
    }

    for (int i = width.length(); i <= 4; i++) {
        width = "0" + width;
    }

    int newHeight = stoi(height.substr(0, 3)) * 100;
    int newWidth = stoi(width.substr(0, 3)) * 100;

    return Size(newWidth, newHeight);
}

/*
 * Function that only goes until the resizing of the image.
 * Used for prediction diagnostics when drawing the results
 * onto the resized image.
 */

Mat halfProcessImage(Mat image) {

    Size size = getOptimalSize(image);

    Mat resizedImage;
    resize(image, resizedImage, size);

    return resizedImage;
}

/*
 * Function that prepares the image for further analysis, by
 * resizing, converting to Grayscale and calculating the best
 * threshold to separate the features better
 */
Mat preprocessImage(Mat image, bool training) {

    Size size = getOptimalSize(image);

    Mat resizedImage;
    resize(image, resizedImage, size);

    Mat grayImage;
    cvtColor(resizedImage, grayImage, COLOR_BGR2GRAY);

    Mat blurImage;
    GaussianBlur(grayImage, blurImage, Size(5, 5), 0);

    Mat threshImage;
    if (!training)
        adaptiveThreshold(blurImage, threshImage, 255, ADAPTIVE_THRESH_GAUSSIAN_C, THRESH_BINARY, 65, 15);
    else
        adaptiveThreshold(blurImage, threshImage, 255, ADAPTIVE_THRESH_GAUSSIAN_C, THRESH_BINARY, 25, 15);

    Mat laplacianImage;
    Laplacian(threshImage, laplacianImage, CV_8UC1);

    vector<Vec4i> houghLines;
    if (!training)
        HoughLinesP(laplacianImage, houghLines, 1, CV_PI / 180, 50, 50, 50);
    else
        HoughLinesP(laplacianImage, houghLines, 1, CV_PI / 180, 100, 50, 10);

    for (size_t i = 0; i < houghLines.size(); i++) {
        Vec4i l = houghLines[i];

        double angle = atan2(l[3] - l[1], l[2] - l[0]) * 180.0 / CV_PI;

        if(angle < 5 && angle >= -5)
            line(laplacianImage, Point(l[0], l[1]), Point(l[2], l[3]), Scalar(0, 0, 0), 2);
    }

    /*
     * Uncomment the line below for debug output on the bounding symbols algorithm.
     */

    // getBoundingSymbols(laplacianImage, 100, true, true, resizedImage);

    return laplacianImage;
}

/*
 * Overriding the function above in a different signature,
 * for easier calling on different types of data (training vs testing).
 */

Mat preprocessImage(Mat image) {
    return preprocessImage(image, false);
}

/*
 * Different approach of image preprocessing specific for symbols,
 * which works best for predicting a whole expression, without calculating
 * lines and removing them.
 */

Mat preprocessSymbols(Mat image) {

    Size size = getOptimalSize(image);

    Mat resizedImage;
    resize(image, resizedImage, size);

    Mat grayImage;
    cvtColor(resizedImage, grayImage, COLOR_BGR2GRAY);

    Mat blurImage;
    GaussianBlur(grayImage, blurImage, Size(5, 5), 0);

    Mat threshImage;
    adaptiveThreshold(blurImage, threshImage, 255, ADAPTIVE_THRESH_GAUSSIAN_C, THRESH_BINARY_INV, 15, 15);

    Mat laplacianImage;
    Laplacian(threshImage, laplacianImage, CV_8UC1);

    /*
     * Uncomment the line below for debug output on the bounding symbols algorithm.
     */

    // getBoundingSymbols(laplacianImage, 100, true, true, resizedImage);

    return laplacianImage;
}
