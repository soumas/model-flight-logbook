import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/utils/mfl_theme.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpoint_state.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';

class TerminalNameDisplay extends StatelessWidget {
  const TerminalNameDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TerminalDetails?>(
      valueListenable: injector.get<GlobalEndpointState>().activeTerminalDetails,
      builder: (context, value, child) {
        return value == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Text(value.airportname, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.3), textAlign: TextAlign.center),
                  Text(
                    value.terminalname,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kColorFontSub),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
      },
    );
  }
}
