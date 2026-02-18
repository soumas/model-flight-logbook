import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/exception_util.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_message.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpoint_state.dart';

class EndpointErrorMessage extends StatelessWidget {
  const EndpointErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
      valueListenable: injector.get<GlobalEndpointState>().activeTerminalDetailsUpdateError,
      builder: (context, error, child) {
        if (error == null) {
          return SizedBox.shrink();
        } else {
          final endpoint = injector.get<GlobalEndpointState>().activeEndpoint.value;
          final message = ExceptionUtil.getUiMessage(context, error);
          return MflMessage(
            severity: MflMessageSeverity.error,
            text: endpoint != null
                ? 'Die Verbindung mit ${endpoint.serverurl}, ${endpoint.terminalid}, konnte nicht hergestellt werden. Details: $message'
                : 'Keine Verbindung ausgewählt - bitte im Menü wählen bzw. hinzufügen.',
          );
        }
      },
    );
  }
}
