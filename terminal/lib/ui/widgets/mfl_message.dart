import 'package:flutter/material.dart';

class MflMessage extends StatelessWidget {
  const MflMessage({
    super.key,
    this.severity = MflMessageSeverity.info,
    this.text,
    this.icon,
    this.child,
  });

  final MflMessageSeverity severity;
  final String? text;
  final Widget? icon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _evalBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: icon != null ? 0.0 : 8.0,
                  ),
                  child: icon ??
                      Icon(
                        _evalIcon(),
                        size: (Theme.of(context).textTheme.bodyLarge?.fontSize! ?? 5) * 1.5,
                        color: _evalFontColor(),
                      ),
                ),
                Container(
                  child: Text(
                    text ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: _evalFontColor()),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  IconData? _evalIcon() {
    switch (severity) {
      case MflMessageSeverity.info:
        return Icons.info_outline_rounded;
      case MflMessageSeverity.warn:
        return Icons.warning_amber_outlined;
      case MflMessageSeverity.error:
        return Icons.remove_circle_outline_outlined;
    }
  }

  _evalBackgroundColor() {
    switch (severity) {
      case MflMessageSeverity.info:
        return Colors.grey.withAlpha(40);
      case MflMessageSeverity.warn:
        return Colors.orange;
      case MflMessageSeverity.error:
        return Colors.redAccent;
    }
  }

  _evalFontColor() {
    switch (severity) {
      case MflMessageSeverity.info:
        return Colors.white;
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
