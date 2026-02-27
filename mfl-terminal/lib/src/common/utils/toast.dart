import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_theme.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static void success({required BuildContext context, required String message}) {
    Toast.show(context: context, message: message, icondata: Icons.check, type: ToastificationType.success);
  }

  static void error({required BuildContext context, required String message}) {
    Toast.show(context: context, message: message, icondata: Icons.error, type: ToastificationType.error);
  }

  static void info({required BuildContext context, required String message}) {
    Toast.show(context: context, message: message, icondata: Icons.info, type: ToastificationType.info);
  }

  static void show({required BuildContext context, required String message, required ToastificationType type, IconData? icondata}) {
    toastification.show(
      context: context,
      description: Text(message, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kColorFontMain)),
      autoCloseDuration: const Duration(seconds: 5),
      icon: icondata != null ? Icon(icondata, size: 38) : const SizedBox(),
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      alignment: const Alignment(0, 1),
      showProgressBar: false,
      closeOnClick: true,
      dragToClose: true,
      pauseOnHover: false,
      type: type,
      backgroundColor: kColorInputBg,
      borderSide: const BorderSide(color: kColorFontMain, width: 1),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
