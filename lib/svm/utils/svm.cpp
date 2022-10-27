#include <cstdlib>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>
#include <opencv2/core/matx.hpp>

using namespace std;
using namespace cv;

/*
 * Configuring the SVM with the optimal parameters
 * for handwriting identification.
 */

void svmSetupForTraining(Ptr<ml::SVM> svm) {

    svm -> setC(12.5);
    svm -> setGamma(0.5);
    svm -> setKernel(ml::SVM::RBF);
    svm -> setType(ml::SVM::C_SVC);
    
}

/*
 * Train the data and save it.
 */

void svmTrain(Ptr<ml::SVM> svm, Mat hogMat, vector<int> trainLabels) {

    svmSetupForTraining(svm);

    Ptr<ml::TrainData> data = ml::TrainData::create(hogMat, ml::ROW_SAMPLE, trainLabels);

    svm -> trainAuto(data);

    svm -> save("lib/src/svm/assets/trainedData.yml");
}

/*
 * Test the data and return the prediction as an array of string.
 */

vector<string> svmTest(Ptr<ml::SVM> svm, Mat hogMat) {

    vector<string> answer;

    Mat answerMat;

    svm -> predict(hogMat, answerMat);

    for (int i = 0; i < answerMat.rows; i++) {
        answer.push_back((string)"" + (char) answerMat.at<float>(i, 0));
    }

    return answer;
}
