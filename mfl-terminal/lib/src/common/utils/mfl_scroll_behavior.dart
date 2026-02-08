import 'dart:ui';

import 'package:flutter/material.dart';

class MflScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch /* makes scrollin work for linux touch, could make problems with other devices but this is untested */,
        PointerDeviceKind.mouse,
      };
}
