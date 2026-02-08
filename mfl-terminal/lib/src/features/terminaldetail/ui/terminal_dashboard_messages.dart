import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_messages_column.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_active_endpoint_state.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';

class TerminalDashboardMessages extends StatelessWidget {
  const TerminalDashboardMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TerminalDetails?>(
      valueListenable: injector.get<GlobalActiveEndpointState>().activeTerminalDetails,
      builder: (context, value, child) {
        return value == null
            ? const SizedBox.shrink()
            : MflMessagesColumn(errorMessages: [], warnMessages: [], infoMessages: value.dashboardMessages ?? []);
      },
    );
  }
}
