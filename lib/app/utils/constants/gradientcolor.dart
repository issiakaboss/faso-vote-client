import 'package:flutter/material.dart';

class GradientColor {
 static gradient(Color cl1, cl2) {
    return LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
      cl1,
      cl2
 
    ]);
  }

static  gradientapbarbutton(Color cl1, cl3){
return LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
      cl1,
      cl3
    ]);
  }

   
}


