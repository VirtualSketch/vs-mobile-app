#include <cstdlib>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>
#include <opencv4/opencv2/core/matx.hpp>
#include <string>

using namespace std;
using namespace cv;

void showImage(string name, Mat image, bool save) {
    namedWindow(name, WINDOW_KEEPRATIO);
    imshow(name, image);
    waitKey(0);
    destroyWindow(name);

    if (save)
        imwrite("assets/" + name, image);
}

int main(void) {


    Mat image = imread("assets/realtest3.jpg");
    /* bitwise_not(image, image); */
    /* showImage("Original", image); */

    cout << image.cols << ", " << image.rows << endl;

    Mat resizedImage;
    resize(image, resizedImage, Size(700, 300));
    /* showImage("Resized", resizedImage); */

    Mat grayImage;
    cvtColor(resizedImage, grayImage, COLOR_BGR2GRAY);
    /* showImage("Grayscale", grayImage); */

    Mat bestImage;
    vector<Mat> biggestNumbers;
    int bestThresh;

    for (int thresh = 0; thresh < 266; thresh++) {

        Mat threshImage;
        /* cout << "Before Threshold " << thresh << endl; */
        threshold(grayImage, threshImage, thresh, 255, THRESH_BINARY);
        /* showImage("Thresh: " + to_string(thresh), threshImage, false); */

        /* cout << "Finding contours..." << endl; */
        vector<vector<Point>> contours;
        vector<Vec4i> hierarchy;
        findContours(threshImage, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE);

        /* cout << "Drawing contours..." << endl; */
        Mat imageClone = resizedImage.clone();
        /* drawContours(imageClone, contours, -1, Scalar(0, 255, 0), 1); */
        /* showImage("Contours with NONE", imageClone); */

        imageClone = resizedImage.clone();
        vector<Mat> numbers;
        vector<int> numbersX, numbersY;
        
        /* cout << "Rectangle for loop..." << endl; */
        for (int i = 0; i < contours.size(); i++) {
            Rect bound = boundingRect(contours.at(i));
            if (bound.height >= 15 && bound.width >= 15 && bound.area() > 1000 && bound.area() < 400 * 400) {
                if (thresh == 172)
                    cout << bound.area() << endl;

                int beginX = bound.x - 10;
                int endX = bound.x + bound.width + 10;
                int beginY = bound.y - 10;
                int endY = bound.y + bound.height + 10;

                numbersX.push_back(bound.x);
                numbersY.push_back(bound.y);

                try {
                    numbers.push_back(threshImage.colRange(beginX, endX).rowRange(beginY, endY).clone());
                    rectangle(imageClone, Point(beginX, beginY), Point(endX, endY), Scalar(0, 255, 0), 2);
                } catch (cv::Exception exc) {
                    /* cout << "Noticed invalid range, continuing..." << endl; */
                    continue;
                }

            }
        }

        if (numbers.size() > biggestNumbers.size()) {
            bestImage = imageClone;
            biggestNumbers = numbers;
            bestThresh = thresh;
        }

    }

    cout << "The best thresh is: " << bestThresh << endl;
    cout << "With a quantity of " << biggestNumbers.size() << " numbers" << endl;

    showImage("bestImage.jpeg", bestImage, false);

    return 0;
}
