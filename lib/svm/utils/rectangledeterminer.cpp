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
 * Function to show image and resize it to a comfortable size.
 * Used for debugging and diagnostics.
 */

/* void showImage(string name, Mat image) { */
/*     namedWindow(name, WINDOW_KEEPRATIO); */
/*     imshow(name, image); */
/*     resizeWindow(name, 500, 500); */
/*     waitKey(0); */
/*     destroyWindow(name); */
/* } */

/* Calculating rectangle bounds on the contours.
 * This function goes by the following strategy:
 *
 * 1. Determine the basic contours of the image
 * 2. Draw a more significant line on top of these contours to merge them together
 * 3. Calculate a second set of contours on top of these drawn lines
 * 4. Determine the Bounding Rectangles of this second set of contours based on a given area
 * 5. Group the rectangles together, as it's common for a symbol to have more than one rectangle
 * 6. Expand the rectangles as much as possible to involve that symbol (starting from 10 pixels)
 * 7. Add them to the coordinatedMat data
 * 8. Do a simples sort of the symbols based on their X coordinate
 * 9. Return the coordinatedMat of the symbols and their position
 */

coordinatedMat getBoundingSymbols(Mat changedImage, int area, bool training, bool debugMode, Mat resizedImage) {

    Mat bestImage;
    vector<Mat> biggestNumbers;
    int bestThresh;

    vector<vector<Point>> contours, contours2;
    vector<Vec4i> hierarchy, hierarchy2;
    findContours(changedImage, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE);
    drawContours(changedImage, contours, -1, Scalar(255, 255, 255));

    Mat imageClone;

    if (debugMode) imageClone = resizedImage.clone();
    
    findContours(changedImage, contours2, hierarchy2, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);

    vector<Mat> numbers;
    vector<int> numbersX, numbersY;
    vector<Rect> rects;

    for (int i = 0; i < contours2.size(); i++) {
        for (int j = contours2.size() - 1; j > i; j--) {
            if (boundingRect(contours2.at(i)).x > boundingRect(contours.at(j)).x) {
                vector<Point> temp = contours.at(i);
                contours.at(i) = contours.at(j);
                contours.at(j) = temp;
            }
        }
    }

    for (int i = 0; i < contours2.size(); i++) {

        Rect bound = boundingRect(contours2.at(i));

        if ((training && bound.width < 50 && bound.area() > area && bound.area() < 10000) || 
                (!training && bound.area() > area && bound.area() < 10000)) {

            rects.push_back(bound);
            rects.push_back(bound);
        }
    }

    groupRectangles(rects, 1, 1.0);

    for (Rect rect: rects) {

        for (int i = 10; i >= 0; i--) {
            int beginX = rect.x - i;
            int endX = rect.x + rect.width + i;
            int beginY = rect.y - i;
            int endY = rect.y + rect.height + i;

            try {
                numbers.push_back(changedImage.colRange(beginX, endX).rowRange(beginY, endY).clone());
                numbersX.push_back(rect.x);
                numbersY.push_back(rect.y);
                if (debugMode) rectangle(imageClone, Point(beginX, beginY), Point(endX, endY), Scalar(0, 0, 255), 2);
                break;
            } catch (cv::Exception exc) {
                continue;
            }
        }
    }

    for (int i = 0; i < numbersX.size(); i++) {
        for (int j = numbersX.size() - 1; j > i; j--) {
            if (numbersX.at(i) > numbersX.at(j)) {
                int temp = numbersX.at(i);
                numbersX.at(i) = numbersX.at(j);
                numbersX.at(j) = temp;

                temp = numbersY.at(i);
                numbersY.at(i) = numbersY.at(j);
                numbersY.at(j) = temp;

                Mat tempMat = numbers.at(i);
                numbers.at(i) = numbers.at(j);
                numbers.at(j) = tempMat;
            }
        }
    }

    /* if (debugMode) showImage("Bounded Rects", imageClone); */
    
    return coordinatedMat {
        numbers,
        numbersX,
        numbersY
    };
}

/* 
 * Two overrides for the function above for easier calling
 * between the training data and the testing one.
 */

coordinatedMat getBoundingSymbols(Mat changedImage, int area) {
    return getBoundingSymbols(changedImage, area, false, false, Mat());
}

coordinatedMat getBoundingSymbols(Mat changedImage, int area, bool training) {
    return getBoundingSymbols(changedImage, area, training, false, Mat());
}
