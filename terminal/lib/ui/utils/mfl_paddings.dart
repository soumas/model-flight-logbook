import 'package:flutter/material.dart';

class MflPaddings {
  static verticalSmallSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.04;
  }

  static verticalMediumSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.08;
  }

  static verticalLargeSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.12;
  }

  static verticalSmall(BuildContext context) => Padding(padding: EdgeInsets.only(top: verticalSmallSize(context)));
  static verticalMedium(BuildContext context) => Padding(padding: EdgeInsets.only(top: verticalMediumSize(context)));
  static verticalLarge(BuildContext context) => Padding(padding: EdgeInsets.only(top: verticalLargeSize(context)));
}
