import 'package:flutter/cupertino.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BoxConstraints constraints, Orientation orientation){
    if(orientation == Orientation.portrait){
      screenHeight = constraints.maxHeight;
      screenWidth = constraints.maxWidth;
    }
    else if(orientation == Orientation.landscape){
      screenHeight = constraints.maxWidth;
      screenWidth = constraints.maxHeight;
    }
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}