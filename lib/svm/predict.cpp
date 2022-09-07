#include <cstdlib>
#include <cstring>
#include <iostream>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/ml.hpp>
#include <opencv2/core/matx.hpp>
#include <string>
#include <filesystem>
#include "utils/coordinatedMat.hpp"
#include "utils/descriptordeterminer.hpp"
#include "utils/imagepreprocessing.hpp"
#include "utils/svm.hpp"

using namespace std;
using namespace cv;

extern "C" const char * predict(void) {

    /*
     * All predictions from image1 to image3 were used to
     * calibrate the image preprocessing and the SVM.
     * That's why they are commented in the code.
     *
     * Uncomment them to see the other results.
     */

    // Mat image1 = preprocessImage("./assets/mynumbers.jpeg");
    // Mat image2 = preprocessImage("./assets/realtest2.jpeg");
    // Mat image3 = preprocessImage("./assets/realtest3.jpg");
    /* Mat image4 = preprocessSymbols("/data/data/com.example.virtual_sketch_app/app_flutter/expression2.jpg"); */
    Mat image4 = preprocessSymbols("/data/data/com.example.virtual_sketch_app/cache/expression2.jpg");
    /* Mat image4 = preprocessSymbols("assets/expression2.jpg"); */

    // coordinatedMat coordMat1 = getBoundingSymbols(image1, 100);
    // coordinatedMat coordMat2 = getBoundingSymbols(image2, 100);
    // coordinatedMat coordMat3 = getBoundingSymbols(image3, 100);
    coordinatedMat coordMat4 = getBoundingSymbols(image4, 100);

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


    // Mat descriptorsMat1 = getHogDescriptorsMat(determineHogDescriptors(hog, coordMat1));
    // Mat descriptorsMat2 = getHogDescriptorsMat(determineHogDescriptors(hog, coordMat2));
    // Mat descriptorsMat3 = getHogDescriptorsMat(determineHogDescriptors(hog, coordMat3));
    Mat descriptorsMat4 = getHogDescriptorsMat(determineHogDescriptors(hog, coordMat4));

    Ptr<ml::SVM> svm = ml::SVM::load("/data/data/com.example.virtual_sketch_app/cache/trainedData.yml");

    // vector<string> answers1 = svmTest(svm, descriptorsMat1);
    // vector<string> answers2 = svmTest(svm, descriptorsMat2);
    // vector<string> answers3 = svmTest(svm, descriptorsMat3);
    vector<string> answers4 = svmTest(svm, descriptorsMat4);

    /*
     * Uncomment the lines below to see prediction results
     * for each image
     */

    // Mat imageClone1 = halfProcessImage("./assets/mynumbers.jpeg");
    // Mat imageClone2 = halfProcessImage("./assets/realtest2.jpeg");
    // Mat imageClone3 = halfProcessImage("./assets/realtest3.jpg");
    // Mat imageClone4 = halfProcessImage("./assets/expression2.jpg");

    // for (int i = 0; i < answers1.size(); i++) {
    //     putText(imageClone1, answers1.at(i), Point(coordMat1.numbersX.at(i), coordMat1.numbersY.at(i)), FONT_HERSHEY_PLAIN, 1.0, Scalar(0, 0, 255));
    // }

    // for (int i = 0; i < answers2.size(); i++) {
    //     putText(imageClone2, answers2.at(i), Point(coordMat2.numbersX.at(i), coordMat2.numbersY.at(i)), FONT_HERSHEY_PLAIN, 1.0, Scalar(0, 0, 255));
    // }

    // for (int i = 0; i < answers3.size(); i++) {
    //     putText(imageClone3, answers3.at(i), Point(coordMat3.numbersX.at(i), coordMat3.numbersY.at(i)), FONT_HERSHEY_PLAIN, 1.0, Scalar(0, 0, 255));
    // }

    // for (int i = 0; i < answers4.size(); i++) {
    //     putText(imageClone4, answers4.at(i), Point(imageClone4.cols - (imageClone4.cols / 4 - (10 * i)), imageClone4.rows - 10), FONT_HERSHEY_PLAIN, 1.0, Scalar(0, 0, 255));
    // }

    // showImage("1", imageClone1);
    // showImage("2", imageClone2);
    // showImage("3", imageClone3);
    // showImage("4", imageClone4);

    string output = "";

    for (string element: answers4)
        output += element;

    char * outputToChar = new char[output.size() + 1];

    copy(output.begin(), output.end(), outputToChar);

    outputToChar[output.size()] = '\0';

    const char * predicted = outputToChar;

    return predicted;
}
