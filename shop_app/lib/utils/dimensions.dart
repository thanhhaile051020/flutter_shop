import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = 824;
  static double screenWidth = 412;
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;
//dynamic height
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.4;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;
//dynamic width
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.4;
  static double width30 = screenHeight / 28.13;

  static double font20 = screenHeight / 42.2;

  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.3;

  //icon size
  static double iconSize24 = screenHeight / 35.17;

  static double heightDynamic(double value) {
    return screenHeight / (844 / value);
  }

  static double widthDynamic(double value) {
    return screenHeight / (844 / value);
  }

  static double iconDynamic(double value) {
    return screenHeight / (844 / value);
  }

  static double roundDynamic(double value) {
    return screenHeight / (844 / value);
  }

  static double fontDynamic(double value) {
    return screenHeight / (844 / value);
  }
}
