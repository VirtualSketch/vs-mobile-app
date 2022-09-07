#include <cstdlib>
#include <iostream>
#include <map>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <string>
#include "coordinatedMat.hpp"

using namespace std;
using namespace cv;

int imageCount = 0;

/* void imageShow(string name, Mat image) { */
/*     namedWindow(name, WINDOW_KEEPRATIO); */
/*     imshow(name, image); */
/*     resizeWindow(name, 500, 500); */
/*     waitKey(0); */
/*     destroyWindow(name); */
/* } */

/*
 * Preparing answer labels for training.
 * A strategy of conditioning on top of the Y coordinate
 * to determine the answer label for a specific digits was used
 * so this task is less time consuming to develop.
 */

vector<char> prepareLabels(coordinatedMat coordMat) {

    int quantNumbers = coordMat.numbers.size();

    vector<char> trainLabels;

    for (int i = 0; i < quantNumbers; i++) {
        Mat currentNum = coordMat.numbers.at(i);
        Mat resizedNum;

        string textNum = to_string(coordMat.numbersY.at(i));

        resize(currentNum, resizedNum, Size(40, 40));
        
        if (imageCount == 1) {
            int num = stoi(textNum);

            char label;

            if (textNum.size() < 3)
                label = '1';
            else {
                if (num > 200 && num < 400)
                    label = '2';
                else if (num > 400 && num < 500)
                    label = '3';
                else if (num > 500 && num < 700)
                    label = '4';
                else if (num > 700 && num < 900)
                    label = '5';
                else if (num > 900 && num < 1100)
                    label = '6';
                else if (num > 1100 && num < 1300)
                    label = '7';
                else if (num > 1300 && num < 1400)
                    label = '8';
                else if (num > 1400 && num < 1550)
                    label = '9';
                else
                    label = '0';
            }

            trainLabels.push_back(label);

        } else if (imageCount == 2) {
            int num = stoi(textNum);

            char label;

            if (num < 50)
                label = '=';
            else if (num > 50 && num < 230)
                label = 'x';
            else if (num > 230 && num < 320)
                label = 'y';
            else if (num > 320 && num < 335)
                label = '-';
            else if (num > 335 && num < 410)
                label = 'y';
            else if (num > 410 && num < 490)
                label = '+';
            else if (num > 490 && num <= 550)
                label = '-';
            else if (num > 550 && num < 600)
                label = '-';
            else if (num > 645 && num < 660)
                label = '/';
            else if (num == 684)
                label = '-';
            else if (num > 733 && num < 745)
                label = '*';
            else if (num > 745 && num < 800)
                label = '-';
            else if (num > 810 && num < 840)
                label = '(';
            else if (num > 840 && num < 861)
                label = '-';
            else if (num > 861 && num < 980)
                label = ')';
            else
                label = 'f';
            trainLabels.push_back(label);

            /*
             * Uncomment the line below for debugging the labelling of the symbols
             */

            // imageShow((string)"" + label + " → " + textNum, currentNum);
        } else {
            if (textNum.size() < 3)
                trainLabels.push_back('1');
            else if (textNum.size() > 3)
                trainLabels.push_back('0');
            else {
                char name;
                if (stoi(textNum) > 700) {
                    name = textNum[0] == '7' ? '8' : textNum[0];
                } else {
                    name = textNum[0] + 1;
                }
                trainLabels.push_back(name);
            }
        }
    }

    imageCount++;

    return trainLabels;
}

/*
 * Converting labels from char to int to use in the SVM training.
 */

vector<int> convertLabels(vector<char> trainLabels) {
    vector<int> convertedLabels;

    for (int i = 0; i < trainLabels.size(); i++) {
        convertedLabels.push_back(trainLabels.at(i));
    }

    return convertedLabels;
}
