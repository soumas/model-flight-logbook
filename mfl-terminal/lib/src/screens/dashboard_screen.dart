import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/main_menu.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/src/common/widgets/uhr_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const route = '/';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      endDrawer: const MainMenu(),
      child1: Column(children: [Placeholder()]),
      child2: Column(
        children: [
          const UhrWidget(),
          const SizedBox(height: 30),
          //const TerminalInfoWidget(),
          const Text('TODO'),
          const SizedBox(height: 40),
          //PilotIdDisplay(input: _input),
          const Text('TODO'),
        ],
      ),
    );
  }
}
