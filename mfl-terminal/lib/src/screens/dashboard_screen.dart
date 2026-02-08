import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/widgets/main_menu.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/src/common/widgets/uhr_widget.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_error_message.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_active_endpoint_state.dart';
import 'package:mfl_terminal/src/features/terminaldetail/ui/operating_hours_display.dart';
import 'package:mfl_terminal/src/features/terminaldetail/ui/terminal_dashboard_messages.dart';
import 'package:mfl_terminal/src/features/terminaldetail/ui/terminal_name_display.dart';
import 'package:mfl_terminal/src/screens/pilot_status_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const route = '/';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _input = '';

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      endDrawer: const MainMenu(),
      child1: Column(children: [const EndpointErrorMessage(), const TerminalDashboardMessages()]),
      child2: Column(
        children: [
          const UhrWidget(),
          const SizedBox(height: 30),
          const TerminalNameDisplay(),
          const SizedBox(height: 30),
          const OperatingHoursDisplay(),
          const SizedBox(height: 30),
          PilotIdDisplay(input: _input),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent && (ModalRoute.of(context)?.isCurrent ?? false)) {
      if (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        final input = _input;
        _input = '';
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PilotStatusScreen(pilotId: input),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        _input = _input.isNotEmpty ? _input.substring(0, _input.length - 1) : '';
      } else {
        _input += event.character ?? '';
      }
      setState(() {});
    }

    return false;
  }
}

class PilotIdDisplay extends StatelessWidget {
  const PilotIdDisplay({super.key, required String input}) : _input = input;

  final String _input;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: injector.get<GlobalActiveEndpointState>().activeTerminalDetails,
      builder: (context, value, child) {
        return value?.showPilotIDOnDashboard ?? false
            ? TextField(
                controller: TextEditingController(text: _input),
                enabled: false,
                textAlign: TextAlign.center,
                canRequestFocus: false,
              )
            : const SizedBox.shrink();
      },
    );
  }
}
