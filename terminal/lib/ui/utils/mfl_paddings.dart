import 'package:flutter/material.dart';

class MflPaddings {
  static verticalSmallSize(BuildContext context) {
    return 10.0;
  }

  static verticalMediumSize(BuildContext context) {
    return verticalSmallSize(context) * 1.5;
  }

  static verticalLargeSize(BuildContext context) {
    return verticalSmallSize(context) * 3;
  }

  static verticalSmall(BuildContext context) => Padding(padding: EdgeInsets.only(top: verticalSmallSize(context)));
  static verticalMedium(BuildContext context) => Padding(padding: EdgeInsets.only(top: verticalMediumSize(context)));
  static verticalLarge(BuildContext context) => Padding(padding: EdgeInsets.only(top: verticalLargeSize(context)));
}
