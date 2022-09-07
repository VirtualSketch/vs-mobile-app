/* #include <iostream> */
/* #include <cstring> */
/* #include <vector> */
/* #include <opencv4/opencv2/core/cvstd_wrapper.hpp> */
/* #include <opencv4/opencv2/core/hal/interface.h> */
/* #include <opencv2/opencv.hpp> */
/* #include <opencv2/objdetect.hpp> */
/* #include <opencv2/ml.hpp> */
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>

using namespace cv;
using namespace std;

int SZ { 20 };
float affineFlags = WARP_INVERSE_MAP | INTER_LINEAR;
string pathName = "assets/dataset.png";

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

/* From a given image, this function will separate the letters for training
 * and the letters that are going to be used for testing, considering that a
 * letter will be a cell with 20x20 pixels of size*/
void loadTrainTestLabel(string &pathName,
        vector<Mat> &trainCells,
        vector<Mat> &testCells,
        vector<int> &trainLabels,
        vector<int> &testLabels)
{
    Mat img = imread(pathName, IMREAD_GRAYSCALE);

    int imgCount = 0;

    /* separate the training cells from the test cells
     * training cells are going to be 90% of the image
     * test cells are going to be 10% of the remaining */
    for (int i = 0; i < img.rows; i += SZ) {

        for (int j = 0; j < img.cols; j += SZ) {

            Mat digitImg = (img.colRange(j, j + SZ).rowRange(i, i + SZ).clone());

            if (j < static_cast<int>(0.9 * img.cols))
                trainCells.push_back(digitImg);
            else
                testCells.push_back(digitImg);

            imgCount++;

        }
    }
    cout << "Image Count: " << imgCount << endl;

    // Specify the training labels for the training dataset
    float digitClassNumber {0};

    for (int l = 0; l < static_cast<int>(0.9 * imgCount); l++) {

        if (l % 450 == 0 && l != 0)
            digitClassNumber++;

        trainLabels.push_back(digitClassNumber);
    }

    // specify the test labels for the test dataset
    digitClassNumber = 0;

    for (int l = 0; l < static_cast<int>(0.1 * imgCount); l++) {

        if (l % 50 == 0 && l != 0)
            digitClassNumber++;

        testLabels.push_back(digitClassNumber);
    }
}

Mat deskew(Mat& img)
{
    Moments m = moments(img);

    if (abs(m.mu02) < 1e-2)
        return img.clone();

    float skew = m.mu11 / m.mu02;

    Mat warpMat = (Mat_<float>(2, 3) << 1, skew, -0.5 * SZ * skew, 0, 1, 0);

    Mat imgOut = Mat::zeros(img.rows, img.cols, img.type());

    warpAffine(img, imgOut, warpMat, imgOut.size(), affineFlags);

    return imgOut;
}


void createDeskewedTrainTest(vector<Mat> &deskewedTrainCells,
        vector<Mat> &deskewedTestCells,
        vector<Mat> &trainCells,
        vector<Mat> &testCells)
{
    for (int i = 0; i < trainCells.size(); i++) {
        Mat deskewedImg = deskew(trainCells[i]);
        deskewedTrainCells.push_back(deskewedImg);
    }

    for (int i = 0; i < testCells.size(); i++) {
        Mat deskewedImg = deskew(testCells[i]);
        deskewedTestCells.push_back(deskewedImg);
    }
}

void createTrainTestHOG(vector<vector<float>> &trainHOG,
        vector<vector<float>> &testHOG,
        vector<Mat> &deskewedTrainCells,
        vector<Mat> &deskewedTestCells)
{
    for (int i = 0; i < deskewedTrainCells.size(); i++) {
        vector<float> descriptors;
        hog.compute(deskewedTrainCells[i], descriptors);
        trainHOG.push_back(descriptors);
    }

    for (int i = 0; i < deskewedTestCells.size(); i++) {
        vector<float> descriptors;
        hog.compute(deskewedTestCells[i], descriptors);
        testHOG.push_back(descriptors);
    }
}

void convertVectorToMatrix(vector<vector<float>> &trainHOG,
        vector<vector<float>> &testHOG,
        Mat &trainMat,
        Mat &testMat,
        int descriptorSize)
{
    for (int i = 0; i < trainHOG.size(); i++) {
        for (int j = 0; j < descriptorSize; j++)
            trainMat.at<float>(i, j) = trainHOG[i][j];
    }

    for (int i = 0; i < testHOG.size(); i++) {
        for (int j = 0; j < descriptorSize; j++)
            testMat.at<float>(i, j) = testHOG[i][j];
    }
}

Ptr<ml::SVM> svmInit(float C, float gamma)
{
    Ptr<ml::SVM> svm = ml::SVM::create();

    svm -> setGamma(gamma);
    svm -> setC(C);
    svm -> setKernel(ml::SVM::RBF);
    svm -> setType(ml::SVM::C_SVC);

    return svm;
}

Ptr<ml::SVM> svmLoad(string location, float C, float gamma)
{
    Ptr<ml::SVM> svm = ml::SVM::load(location);

    svm -> setC(C);
    svm -> setGamma(gamma);

    return svm;
}

void svmTrain(Ptr<ml::SVM> svm, Mat &trainMat, vector<int> &trainLabels)
{
    Ptr<ml::TrainData> data = ml::TrainData::create(trainMat, ml::ROW_SAMPLE, trainLabels);
    svm -> train(data);
    svm -> save("trainedData.yml");
}

void svmPredict(Ptr<ml::SVM> svm, Mat &testMat, Mat &testResponse)
{
    svm -> predict(testMat, testResponse);
}

void getSVMParams(ml::SVM *svm)
{
    cout << "Kernel type     : " << svm -> getKernelType() << endl;
    cout << "Type            : " << svm -> getType() << endl;
    cout << "C               : " << svm -> getC() << endl;
    cout << "Degree          : " << svm -> getDegree() << endl;
    cout << "Nu              : " << svm -> getNu() << endl;
    cout << "Gamma           : " << svm -> getGamma() << endl;
}

void SVMEvaluate(Mat &testResponse,
        float &count,
        float &accuracy,
        vector<int> &testLabels)
{
    for (int i = 0; i < testResponse.rows; i++) {
        cout << testResponse.at<float>(i, 0) << " " << testLabels[i] << endl;
        if (testResponse.at<float>(i, 0) == testLabels[i])
            count++;
    }

    cout << endl;

    accuracy = (count / testResponse.rows) * 100;
}

int main(void)
{
    vector<Mat> trainCells, testCells;
    vector<int> trainLabels, testLabels;
    loadTrainTestLabel(pathName, trainCells, testCells, trainLabels, testLabels);

    vector<Mat> deskewedTrainCells, deskewedTestCells;
    createDeskewedTrainTest(deskewedTrainCells, deskewedTestCells, trainCells, testCells);

    vector<vector<float>> trainHOG, testHOG;
    createTrainTestHOG(trainHOG, testHOG, deskewedTrainCells, deskewedTestCells);

    int descriptorSize = trainHOG[0].size();
    cout << "Descriptor size: " << descriptorSize << endl;

    Mat trainMat(trainHOG.size(), descriptorSize, CV_32FC1);
    Mat testMat(testHOG.size(), descriptorSize, CV_32FC1);
    cout << "Converting Vector to Matrix..." << endl;
    convertVectorToMatrix(trainHOG, testHOG, trainMat, testMat, descriptorSize);

    float C = 12.5, gamma = 0.5;

    Mat testResponse;
    cout << "Initializing SVM..." << endl;
    Ptr<ml::SVM> model = svmInit(C, gamma);
    /* Ptr<ml::SVM> model2 = svmLoad("./trainedData.yml", C, gamma); */

    // SVM Training
    cout << "Training SVM..." << endl;
    svmTrain(model, trainMat, trainLabels);

    // SVM Testing
    cout << "Testing SVM..." << endl;
    svmPredict(model, testMat, testResponse);

    // Find accuracy
    float count {0}, accuracy {0};
    getSVMParams(model);
    SVMEvaluate(testResponse, count, accuracy, testLabels);

    cout << "The accuracy for the first is: " << accuracy << endl;

    /* svmPredict(model2, testMat, testResponse); */
    /* getSVMParams(model2); */
    /* SVMEvaluate(testResponse, count, accuracy, testLabels); */
    /* cout << "The accuracy for the second is: " << accuracy << endl; */

    return 0;
}
