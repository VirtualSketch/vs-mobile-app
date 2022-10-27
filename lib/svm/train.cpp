#include <cstdlib>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>
#include <opencv2/core/matx.hpp>
#include <string>
#include "utils/coordinatedMat.hpp"
#include "utils/descriptordeterminer.hpp"
#include "utils/imagepreprocessing.hpp"
#include "utils/labelassigner.hpp"
#include "utils/svm.hpp"

using namespace std;
using namespace cv;

extern "C" void train(void) {

    Mat rawImage1 = imread("assets/numbers1.jpg");
    Mat rawImage2 = imread("assets/numbers2.jpg");
    Mat rawImage3 = imread("assets/symbols2.jpg");

    Mat image1 = preprocessImage(rawImage1, true);
    Mat image2 = preprocessImage(rawImage2, true);
    Mat image3 = preprocessSymbols(rawImage3);

    coordinatedMat coordMat1 = getBoundingSymbols(image1, 100, true);
    coordinatedMat coordMat2 = getBoundingSymbols(image2, 1000, true);
    coordinatedMat coordMat3 = getBoundingSymbols(image3, 100, true);

    /*
     * SVM keeps a tree-like data model to store its training
     * so it's not possible to train it many times, with independent
     * labels for organization, as each training will overwrite the previous one.
     *
     * All labels and features for each independent dataset needs to be concatenated
     * into one only for one big training.
     */

    vector<int> totalTrainLabels;

    vector<char> trainLabels1 = prepareLabels(coordMat1);
    vector<char> trainLabels2 = prepareLabels(coordMat2);
    vector<char> trainLabels3 = prepareLabels(coordMat3);

    totalTrainLabels.insert(totalTrainLabels.end(), trainLabels1.begin(), trainLabels1.end());
    totalTrainLabels.insert(totalTrainLabels.end(), trainLabels2.begin(), trainLabels2.end());
    totalTrainLabels.insert(totalTrainLabels.end(), trainLabels3.begin(), trainLabels3.end());

    HOGDescriptor hog = HOGDescriptor(
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

    vector<vector<float>> totalHogDescriptors;

    vector<vector<float>> hogDescriptors1 = determineHogDescriptors(hog, coordMat1);
    vector<vector<float>> hogDescriptors2 = determineHogDescriptors(hog, coordMat2);
    vector<vector<float>> hogDescriptors3 = determineHogDescriptors(hog, coordMat3);

    totalHogDescriptors.insert(totalHogDescriptors.end(), hogDescriptors1.begin(), hogDescriptors1.end());
    totalHogDescriptors.insert(totalHogDescriptors.end(), hogDescriptors2.begin(), hogDescriptors2.end());
    totalHogDescriptors.insert(totalHogDescriptors.end(), hogDescriptors3.begin(), hogDescriptors3.end());

    Mat totalHogDescriptorsMat = getHogDescriptorsMat(totalHogDescriptors);
    
    Ptr<ml::SVM> svm = ml::SVM::create();

    svmTrain(svm, totalHogDescriptorsMat, totalTrainLabels);

    return;
}
