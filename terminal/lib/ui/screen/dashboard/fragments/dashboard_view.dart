import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfl_terminal/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:mfl_terminal/ui/screen/dashboard/fragments/global_messages_view.dart';
import 'package:mfl_terminal/ui/screen/dashboard/fragments/main_menu.dart';
import 'package:mfl_terminal/ui/screen/dashboard/fragments/terminal_info_widget.dart';
import 'package:mfl_terminal/ui/screen/dashboard/fragments/uhr_widget.dart';
import 'package:mfl_terminal/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:mfl_terminal/ui/widgets/mfl_scaffold.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    super.key,
  });

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final Timer _refreshTerminalStateTimer;
  var _input = '';

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_onKey);
    _refreshTerminalStateTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) => context.read<DashboardCubit>().updateTerminalState(),
    );
  }

  @override
  void dispose() {
    _refreshTerminalStateTimer.cancel();
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent && (ModalRoute.of(context)?.isCurrent ?? false)) {
      if (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        final input = _input;
        _input = '';
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => PilotStatusScreen(pilotId: input),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        _input = _input.isNotEmpty ? _input.substring(0, _input.length - 1) : '';
      } else {
        _input += event.character ?? '';
      }
      setState(() {});
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      //itle: 'Model Flight Logbook',
      showBackgroundImage: true,
      endDrawer: const MainMenu(),
      child1: const GlobalMessagesView(),
      child2: Column(children: [
        const UhrWidget(),
        const SizedBox(height: 30),
        const TerminalInfoWidget(),
        const SizedBox(height: 40),
        PilotIdDisplay(input: _input),
      ]),
    );
  }
}

class PilotIdDisplay extends StatelessWidget {
  const PilotIdDisplay({
    super.key,
    required String input,
  }) : _input = input;

  final String _input;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    return state.selectedEndpoint?.config.showPilotIDOnDashboard ?? false
        ? TextField(
            controller: TextEditingController(text: _input),
            enabled: false,
            textAlign: TextAlign.center,
            canRequestFocus: false,
            decoration: const InputDecoration(hintText: 'Bitte anmelden ...'))
        : const SizedBox.shrink();
  }
}
