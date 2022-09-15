#include <cstdlib>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>
#include <opencv2/core/matx.hpp>
#include <string>

using namespace std;
using namespace cv;

void showImage(string name, Mat image) {
    namedWindow(name, WINDOW_KEEPRATIO);
    imshow(name, image);
    resizeWindow(name, 500, 500);
    waitKey(0);
    destroyWindow(name);
}

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

int main() {

    for (int imageCount = 0; imageCount < 2; imageCount++) {
        
        int width = 1000, height = 1000, thresh = 159;

        if (imageCount > 0)
            width = 2000, height = 1800, thresh = 179;


        Mat image = imread("assets/mydataset.jpeg");

        if (imageCount > 0)
            image = imread("assets/mydataset2.jpg");
        /* bitwise_not(image, image); */
        /* showImage("Original", image); */

        Mat resizedImage;
        resize(image, resizedImage, Size(width, height));
        /* showImage("Resized", resizedImage); */

        Mat grayImage;
        cvtColor(resizedImage, grayImage, COLOR_BGR2GRAY);
        /* showImage("Grayscale", grayImage); */

        Mat threshImage;
        threshold(grayImage, threshImage, thresh, 255, THRESH_BINARY);
        /* showImage("Thresh", threshImage); */

        vector<vector<Point>> contours;
        vector<Vec4i> hierarchy;
        findContours(threshImage, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE);

        Mat imageClone = resizedImage.clone();
        drawContours(imageClone, contours, -1, Scalar(0, 255, 0), 1);
        /* showImage("Contours with NONE", imageClone); */

        imageClone = resizedImage.clone();
        vector<Mat> numbers;
        vector<int> numbersX, numbersY;

        
        for (int i = 0; i < contours.size(); i++) {
            Rect bound = boundingRect(contours.at(i));

            bool condition = bound.width >= 10 && bound.height >= 10 && bound.area() > 400 && bound.area() < 400 * 400;

            if (imageCount > 0)
                condition = bound.area() > 1000 && bound.area() < 1000 * 1000;

            if (condition) {
                /* cout << bound.area() << endl; */

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
                    try {
                        beginX = bound.x;
                        endX = bound.x + bound.width;
                        beginY = bound.y;
                        endY = bound.y + bound.height;

                        numbersX.at(numbersX.size() - 1) = bound.x;
                        numbersY.at(numbersY.size() - 1) = bound.y;

                        numbers.push_back(threshImage.colRange(beginX, endX).rowRange(beginY, endY).clone());

                        rectangle(imageClone, Point(beginX, beginY), Point(endX, endY), Scalar(0, 255, 0), 2);
                    } catch (cv::Exception exc) {
                        continue;
                    }
                }
            }
        }

        /* showImage("Bounded", imageClone); */

        int quantNumbers = numbersX.size();

        /* cout << quantNumbers << " " << numbersY.size() << " " << numbers.size() << endl; */

        for (int j = quantNumbers - 1; j > 0; j--) {
            for (int i = 0; i < j; i++) {
                bool changed = false;

                if (numbersX.at(i) > numbersX.at(i + 1)) {
                    int temp = numbersX.at(i);
                    numbersX.at(i) = numbersX.at(i + 1);
                    numbersX.at(i + 1) = temp;
                    changed = true;
                }
                if (numbersY.at(i) > numbersY.at(i + 1)) {
                    int temp = numbersY.at(i);
                    numbersY.at(i) = numbersY.at(i + 1);
                    numbersY.at(i + 1) = temp;
                    changed = true;
                }
                if (changed) {
                    Mat temp = numbers.at(i);
                    numbers.at(i) = numbers.at(i + 1);
                    numbers.at(i + 1) = temp;
                }
            }
        }

        HOGDescriptor hog = HOGDescriptor(
            /* Size(20, 20), // winSize */
            /* Size(8, 8), // blockSize */
            /* Size(4, 4), // blockStride */
            /* Size(8, 8), // cellSize */
            Size(40, 40), // winSize
            Size(16, 16), // blockSize
            Size(8, 8), // blockStride
            Size(16, 16), // cellSize
            9, // nbins
            1, // derivAper
            -1.0, // winSigma
            HOGDescriptor::L2Hys, // histogramNormType
            0.2, // L2HysThresh
            false, // gammal correction
            64, // nlevels = 64
            true // use signed gradients
        );

        vector<vector<float>> hogDescriptors;
        vector<int> trainLabels;

        for (int i = 0; i < quantNumbers; i++) {
            /* cout << x << endl; */
            Mat currentNum = numbers.at(i);
            Mat resizedNum;

            string textNum = to_string(numbersY.at(i));

            resize(currentNum, resizedNum, Size(40, 40));
            
            Mat deskewedNum = deskew(resizedNum);

            if (imageCount > 0) {
                int num = stoi(textNum);
                int label = -1;
                if (textNum.size() < 3)
                    label = 1;
                else {
                    if (num > 200 && num < 400)
                        label = 2;
                    else if (num > 400 && num < 500)
                        label = 3;
                    else if (num > 500 && num < 700)
                        label = 4;
                    else if (num > 700 && num < 900)
                        label = 5;
                    else if (num > 900 && num < 1100)
                        label = 6;
                    else if (num > 1100 && num < 1300)
                        label = 7;
                    else if (num > 1300 && num < 1400)
                        label = 8;
                    else if (num > 1400 && num < 1600)
                        label = 9;
                    else
                        label = 0;
                }
                trainLabels.push_back(label);
                /* showImage(to_string(label), deskewedNum); */
            } else {
                if (textNum.size() < 3)
                    trainLabels.push_back(1);
                else {
                    string name = "";
                    char appender = textNum[0] == '9' ? '0' : textNum[0] + 1;
                    name += appender;
                    trainLabels.push_back(stoi(name));
                }
            }

            vector<float> numDescriptors;
            hog.compute(deskewedNum, numDescriptors);

            /* cout << numDescriptors[0] << " " << numDescriptors[1] << " " << numDescriptors[2] << endl; */

            hogDescriptors.push_back(numDescriptors);
        }

        int descriptorSize = hogDescriptors.at(0).size();

        Mat hogMat(hogDescriptors.size(), descriptorSize, CV_32FC1);

        for (int i = 0; i < hogDescriptors.size(); i++) {
            for (int j = 0; j < descriptorSize; j++) {
                hogMat.at<float>(i, j) = hogDescriptors[i][j];
            }
        }

        Ptr<ml::SVM> svm = ml::SVM::create();

        if (imageCount > 0)
            svm = ml::SVM::load("assets/trainedData.yml");

        svm -> setC(12.5);
        svm -> setGamma(0.5);
        svm -> setKernel(ml::SVM::RBF);
        svm -> setType(ml::SVM::C_SVC);

        Ptr<ml::TrainData> data = ml::TrainData::create(hogMat, ml::ROW_SAMPLE, trainLabels);

        svm -> trainAuto(data);

        /* if (imageCount > 0) */
        /*     svm -> save("assets/trainedData2.yml"); */
        /* else */
        /*     svm -> save("assets/trainedData.yml"); */

        svm -> save("assets/trainedData.yml");
        

        /* Mat answerMat; */

        // fire time → TESTING
        /* svm -> predict(hogMat, answerMat); */

        /* for (int i = 0; i < answerMat.rows; i++) { */
            /* imshow("Predicted number: " + to_string(answerMat.at<float>(i, 0)), numbers.at(numbersX.at(i))); */
            /* waitKey(0); */
            /* destroyAllWindows(); */
            /* cout << answerMat.at<float>(i, 0) << endl; */
        /* } */
    }


    return 0;
}
