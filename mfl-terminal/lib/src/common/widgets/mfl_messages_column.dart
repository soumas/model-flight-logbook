import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_message.dart';

class MflMessagesColumn extends StatelessWidget {
  const MflMessagesColumn({
    super.key,
    required this.errorMessages,
    required this.warnMessages,
    required this.infoMessages,
    this.onWarnMessageAcceptedChanged,
  });

  final List<String> errorMessages;
  final List<String> warnMessages;
  final List<String> infoMessages;
  final Function(String message, bool accepted)? onWarnMessageAcceptedChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...errorMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.error)),
        ...warnMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.warn, onAcceptedChanged: onWarnMessageAcceptedChanged)),
        ...infoMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.info)),
      ],
    );
  }
}
