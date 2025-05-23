import 'package:flutter/material.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';

class MessagesColumn extends StatelessWidget {
  const MessagesColumn({
    super.key,
    required this.errorMessages,
    required this.warnMessages,
    required this.infoMessages,
  });

  final List<String> errorMessages;
  final List<String> warnMessages;
  final List<String> infoMessages;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...errorMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.error)),
        ...warnMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.warn)),
        ...infoMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.info)),
      ],
    );
  }
}
