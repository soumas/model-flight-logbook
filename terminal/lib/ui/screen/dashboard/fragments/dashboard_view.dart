import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/fragments/global_messages_view.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/fragments/main_menu.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/fragments/terminal_info_widget.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/fragments/uhr_widget.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

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
        Navigator.of(context).pushNamed(PilotStatusScreen.route, arguments: input);
      } else {
        _input += event.character ?? '';
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return const MflScaffold(
      title: 'Model Flight Logbook',
      showBackgroundImage: true,
      endDrawer: MainMenu(),
      child1: GlobalMessagesView(),
      child2: Column(children: [UhrWidget(), SizedBox(height: 30), TerminalInfoWidget(), SizedBox(height: 30)]),
    );
  }
}
