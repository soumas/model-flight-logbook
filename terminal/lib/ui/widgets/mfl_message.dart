import 'package:flutter/material.dart';

class MflMessage extends StatelessWidget {
  const MflMessage({
    super.key,
    this.severity = MflMessageSeverity.none,
    this.text,
    this.child,
  });

  final MflMessageSeverity severity;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015, vertical: 10),
          child: child ??
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10.0),
                  //   child: Icon(_evalIcon(), color: _evalFontColor()),
                  // ),
                  Flexible(
                    child: Text(
                      text?.replaceAll('\\n', '\n') ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: _evalFontColor(),
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }

  _evalIcon() {
    switch (severity) {
      case MflMessageSeverity.none:
      case MflMessageSeverity.info:
        return Icons.info_outline;
      case MflMessageSeverity.warn:
      case MflMessageSeverity.error:
        return Icons.warning_amber_outlined;
    }
  }

  _evalFontColor() {
    switch (severity) {
      case MflMessageSeverity.none:
        return null;
      case MflMessageSeverity.info:
        return Colors.lightBlueAccent;
      case MflMessageSeverity.warn:
        return Colors.orangeAccent;
      case MflMessageSeverity.error:
        return Colors.red;
    }
  }
}

enum MflMessageSeverity {
  none,
  info,
  warn,
  error,
}
