#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>

using namespace std;
using namespace cv;

int cellSize = 20;
float affineFlags = WARP_INVERSE_MAP | INTER_LINEAR;
string imagepath = "assets/test.jpg";
string traineddatapath = "assets/trainedData.yml";

HOGDescriptor hog = HOGDescriptor(
    Size(20, 20), // winSize
    Size(8, 8), // blockSize
    /* Size(10, 10), //blockSize */
    Size(4, 4), // blockStride
    Size(8, 8), // cellSize
    9, // nbins
    1, // derivAper
    -1.0, // winSigma
    HOGDescriptor::L2Hys, // histogramNormType
    0.2, // L2HysThresh
    false, // gammal correction
    64, // nlevels = 64
    true // use signed gradients
);

Mat deskew(Mat &img) {
    Moments m = moments(img);

    if (abs(m.mu02) < 1e-2)
        return img.clone();

    float skew = m.mu11 / m.mu02;

    Mat warpMat = (Mat_<float>(2, 3) << 1, skew, -0.5 * cellSize * skew, 0, 1, 0);

    Mat imgOut = Mat::zeros(img.rows, img.cols, img.type());

    warpAffine(img, imgOut, warpMat, imgOut.size(), affineFlags);

    return imgOut;
}

int main() {

    Mat origImg = imread(imagepath, IMREAD_GRAYSCALE);
    Mat img;

    threshold(origImg, img, 128, 255, THRESH_BINARY | THRESH_OTSU);

    Mat answerMat;

    vector<Mat> digitCells, deskewedCells;
    vector<vector<float>> hogDescriptors;

    cout << "Separating digits by cells of 20x20 pixels in a vector..." << endl;
    // separate digits by cells of 20x20 pixels in a vector
    for (int i = 0; i < img.rows; i += cellSize) {
        for (int j = 0; j < img.cols; j += cellSize) {
            Mat cell = img.colRange(j, j + cellSize).rowRange(i, i + cellSize).clone();
            digitCells.push_back(cell);
        }
    }

    cout << "Deskewing cells one by one..." << endl;
    // deskew cells one by one
    for (int i = 0; i < digitCells.size(); i++) {
        Mat deskewedCell = deskew(digitCells.at(i));
        deskewedCells.push_back(deskewedCell);
    }

    cout << "Specifying HOG descriptors for deskewed digit cells..." << endl;
    // specify HOG descriptors for deskewed digit cells
    for (int i = 0; i < deskewedCells.size(); i++) {
        vector<float> cellDescriptors;
        hog.compute(deskewedCells.at(i), cellDescriptors);
        hogDescriptors.push_back(cellDescriptors);
    }

    cout << "Creating Mat from HOG descriptors..." << endl;
    // create Mat from HOG descriptors
    int descriptorSize = hogDescriptors.at(0).size();
    /* cout << "Descriptor size: " << descriptorSize << endl; */
    /* cout << "hogDescriptors size: " << hogDescriptors.size() << endl; */
    /* cout << hogDescriptors.at(0).at(0) << endl; */
    /* cout << hogDescriptors.at(0).at(1) << endl; */

    Mat hogMat(hogDescriptors.size(), descriptorSize, CV_32FC1);

    for (int i = 0; i < hogDescriptors.size(); i++) {
        for (int j = 0; j < descriptorSize; j++) {
            hogMat.at<float>(i, j) = hogDescriptors[i][j];
        }
    }

    cout << "SVM time!" << endl;
    // initializing SVM and loading with trained data
    Ptr<ml::SVM> svm = ml::SVM::load(traineddatapath);

    svm -> setC(12.5);
    svm -> setGamma(0.5);

    // fire time → TESTING
    svm -> predict(hogMat, answerMat);

    for (int i = 0; i < answerMat.rows; i++) {
        imshow("Predicted number: " + to_string(answerMat.at<float>(i, 0)), digitCells.at(i));
        waitKey(0);
        destroyAllWindows();
    }

    return 0;
}
