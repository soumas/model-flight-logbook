import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static success({required BuildContext context, required String message}) {
    Toast.show(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      icondata: Icons.check,
    );
  }

  static error({required BuildContext context, required String message}) {
    Toast.show(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      icondata: Icons.error,
    );
  }

  static show({required BuildContext context, required String message, Color? backgroundColor, Color? foregroundColor, IconData? icondata}) {
    toastification.show(
      context: context,
      title: Text(
        message,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: foregroundColor),
      ),
      autoCloseDuration: const Duration(seconds: 4),
      icon: icondata != null
          ? Icon(
              icondata,
              color: foregroundColor,
              size: 28,
            )
          : const SizedBox(),
      closeButtonShowType: CloseButtonShowType.none,
      alignment: const Alignment(0, 1),
      showProgressBar: false,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      closeOnClick: true,
    );
  }
}
