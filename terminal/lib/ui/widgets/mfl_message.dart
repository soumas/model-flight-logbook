import 'package:flutter/material.dart';
import 'package:mfl_terminal/ui/utils/mfl_theme.dart';

class MflMessage extends StatefulWidget {
  const MflMessage({super.key, this.severity = MflMessageSeverity.info, this.text, this.onAcceptedChanged});

  static const contentPadding = 10.0;
  static const severityIndicatorWidth = 20.0;

  final MflMessageSeverity severity;
  final String? text;
  final Function(String message, bool accepted)? onAcceptedChanged;

  @override
  State<MflMessage> createState() => _MflMessageState();
}

class _MflMessageState extends State<MflMessage> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MflMessage.contentPadding * 2),
      child: Container(
        width: double.infinity,
        decoration: CustomDecoration(severityColor: _evalBackgroundColor()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: MflMessage.severityIndicatorWidth + MflMessage.contentPadding,
                  bottom: MflMessage.contentPadding,
                  top: MflMessage.contentPadding,
                  right: MflMessage.contentPadding),
              child: Text(
                widget.text?.replaceAll('\\n', '\n') ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
            ),
            if (widget.onAcceptedChanged != null) ...[
              Padding(
                padding: const EdgeInsets.only(
                    left: MflMessage.severityIndicatorWidth + MflMessage.contentPadding,
                    bottom: MflMessage.contentPadding,
                    top: MflMessage.contentPadding,
                    right: MflMessage.contentPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Switch(
                      value: _isAccepted,
                      onChanged: (value) {
                        setState(() {
                          _isAccepted = value;
                          widget.onAcceptedChanged?.call(widget.text ?? '', _isAccepted);
                        });
                      },
                    ),
                    const SizedBox(width: MflMessage.contentPadding),
                    Text(
                      'akzeptieren',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kColorFontMain.withAlpha(150)),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Color _evalBackgroundColor() {
    switch (widget.severity) {
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
