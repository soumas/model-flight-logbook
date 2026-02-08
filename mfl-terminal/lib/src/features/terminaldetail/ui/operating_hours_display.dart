import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/utils/mfl_theme.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_active_endpoint_state.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';

class OperatingHoursDisplay extends StatelessWidget {
  const OperatingHoursDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TerminalDetails?>(
      valueListenable: injector.get<GlobalActiveEndpointState>().activeTerminalDetails,
      builder: (context, value, child) {
        return value == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  if (value.operatinghourStart != null) ...[
                    Text(
                      '${DateFormat.Hm().format(value.operatinghourStart!)} - ${DateFormat.Hm().format(value.operatinghourEnd!)}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.3),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Betriebszeit',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kColorFontSub),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              );
      },
    );
  }
}
