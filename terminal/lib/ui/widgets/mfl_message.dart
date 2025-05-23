import 'package:flutter/material.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/utils/mfl_theme.dart';

class MflMessage extends StatelessWidget {
  const MflMessage({
    super.key,
    this.severity = MflMessageSeverity.info,
    this.text,
  });

  static const contentPadding = 10.0;
  static const severityIndicatorWidth = 20.0;

  final MflMessageSeverity severity;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: contentPadding * 2),
      child: Container(
        width: double.infinity,
        decoration: CustomDecoration(severityColor: _evalBackgroundColor()),
        child: Padding(
          padding: const EdgeInsets.only(left: severityIndicatorWidth + contentPadding, bottom: contentPadding, top: contentPadding, right: contentPadding),
          child: Text(
            text?.replaceAll('\\n', '\n') ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }

  Color _evalBackgroundColor() {
    switch (severity) {
      case MflMessageSeverity.info:
        return kColorInfo;
      case MflMessageSeverity.warn:
        return kColorWarning;
      case MflMessageSeverity.error:
        return kColorError;
    }
  }
}

class CustomDecoration extends Decoration {
  const CustomDecoration({required this.severityColor});

  final Color severityColor;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return BoxDecorationPainter(severityColor: severityColor);
  }
}

class BoxDecorationPainter extends BoxPainter {
  const BoxDecorationPainter({required this.severityColor});

  final Color severityColor;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    _drawDecoration(canvas, bounds, severityColor);
  }
}

void _drawDecoration(Canvas canvas, Rect size, Color severtyColor) {
  final fullRect = RRect.fromRectAndRadius(size, const Radius.circular(kCornderRadius));
  final severityRect = RRect.fromRectAndCorners(
    Rect.fromLTRB(size.left, size.top, size.left + MflMessage.severityIndicatorWidth, size.bottom),
    topLeft: const Radius.circular(kCornderRadius),
    bottomLeft: const Radius.circular(kCornderRadius),
  );

  var bgPaint = Paint()..color = kColorCard;
  var severityPaint = Paint()..color = severtyColor;

  canvas.drawRRect(fullRect, bgPaint);
  canvas.drawRRect(severityRect, severityPaint);
}

enum MflMessageSeverity {
  info,
  warn,
  error,
}
