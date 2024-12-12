import 'package:flutter/material.dart';

class MflMessage extends StatelessWidget {
  const MflMessage({
    super.key,
    this.severity = MflMessageSeverity.info,
    this.text,
    this.child,
  });

  final MflMessageSeverity severity;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _evalBackgroundColor(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: child ??
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015),
                child: Text(
                  text ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: _evalFontColor()),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
      ),
    );
  }

  _evalBackgroundColor() {
    switch (severity) {
      case MflMessageSeverity.info:
        return Colors.lightBlueAccent;
      case MflMessageSeverity.warn:
        return Colors.orange;
      case MflMessageSeverity.error:
        return Colors.redAccent;
    }
  }

  _evalFontColor() {
    switch (severity) {
      case MflMessageSeverity.info:
        return Colors.black;
      case MflMessageSeverity.warn:
        return Colors.black;
      case MflMessageSeverity.error:
        return Colors.white;
    }
  }
}

enum MflMessageSeverity {
  info,
  warn,
  error,
}
