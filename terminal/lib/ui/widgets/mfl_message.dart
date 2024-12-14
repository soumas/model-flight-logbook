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
      color: _evalBackgroundColor(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015),
          child: child ??
              Text(
                text?.replaceAll('\\n', '\n') ?? '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: _evalFontColor()),
                textAlign: TextAlign.center,
              ),
        ),
      ),
    );
  }

  _evalBackgroundColor() {
    switch (severity) {
      case MflMessageSeverity.none:
        return null;
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
      case MflMessageSeverity.none:
        return null;
      case MflMessageSeverity.info:
        return Colors.deepPurple;
      case MflMessageSeverity.warn:
        return Colors.black;
      case MflMessageSeverity.error:
        return Colors.white;
    }
  }
}

enum MflMessageSeverity {
  none,
  info,
  warn,
  error,
}
