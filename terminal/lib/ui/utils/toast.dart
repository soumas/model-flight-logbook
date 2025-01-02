import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static success({required BuildContext context, required String message}) {
    Toast.show(
      context: context,
      message: message,
      icondata: Icons.check,
      type: ToastificationType.success,
    );
  }

  static error({required BuildContext context, required String message}) {
    Toast.show(
      context: context,
      message: message,
      icondata: Icons.error,
      type: ToastificationType.error,
    );
  }

  static info({required BuildContext context, required String message}) {
    Toast.show(
      context: context,
      message: message,
      icondata: Icons.info,
      type: ToastificationType.info,
    );
  }

  static show({required BuildContext context, required String message, ToastificationType? type, IconData? icondata}) {
    toastification.show(
      context: context,
      description: Text(message, style: Theme.of(context).textTheme.titleLarge),
      autoCloseDuration: const Duration(seconds: 5),
      icon: icondata != null ? Icon(icondata, size: 38) : const SizedBox(),
      closeButtonShowType: CloseButtonShowType.none,
      alignment: const Alignment(0, 1),
      showProgressBar: false,
      closeOnClick: true,
      dragToClose: true,
      pauseOnHover: false,
      type: type,
    );
  }
}
