#ifndef svmH
#define svmH 

#include <cstdlib>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>
#include <opencv2/core/matx.hpp>

using namespace std;
using namespace cv;

void svmSetupForTraining(Ptr<ml::SVM> svm);

void svmTrain(Ptr<ml::SVM> svm, Mat hogMat, vector<int> trainLabels);

vector<string> svmTest(Ptr<ml::SVM> svm, Mat hogMat);

#endif


