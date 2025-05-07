import 'package:flutter/material.dart';

import 'tooltipContentType.dart';

abstract class TooltipContent {
  static late dynamic controller;
  dynamic getValue() => "";
  double getMaxHeight() => 0.0;
  double getMaxWidth(BuildContext context) => 0.0;
  // TooltipContent setValue(v) {
  //   controller.text = v;
  //   return this;
  // }

  factory TooltipContent.text({String defaultValue = ''}) {
    return TooltipContentText(defaultValue: defaultValue);
  }

 
}
