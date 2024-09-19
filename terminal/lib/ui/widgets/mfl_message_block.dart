import 'package:flutter/material.dart';

class MflMessageBlock extends StatelessWidget {
  const MflMessageBlock({
    super.key,
    this.severity = MflCardSeverity.info,
    required this.text,
    this.icon,
  });

  final MflCardSeverity severity;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _evalBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: Icon(
                _evalIcon(),
                size: (Theme.of(context).textTheme.bodyLarge?.fontSize! ?? 5) * 1.5,
                color: _evalFontColor(),
              ),
            ),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: _evalFontColor()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData? _evalIcon() {
    if (icon != null) {
      return icon!;
    }
    switch (severity) {
      case MflCardSeverity.info:
        return Icons.info;
      case MflCardSeverity.warn:
        return Icons.warning;
      case MflCardSeverity.error:
        return Icons.error;
    }
  }

  _evalBackgroundColor() {
    switch (severity) {
      case MflCardSeverity.info:
        return Colors.blue;
      case MflCardSeverity.warn:
        return Colors.orange;
      case MflCardSeverity.error:
        return Colors.redAccent;
    }
  }

  _evalFontColor() {
    switch (severity) {
      case MflCardSeverity.info:
        return Colors.white;
      case MflCardSeverity.warn:
        return Colors.black87;
      case MflCardSeverity.error:
        return Colors.white;
    }
  }
}

enum MflCardSeverity {
  info,
  warn,
  error,
}
