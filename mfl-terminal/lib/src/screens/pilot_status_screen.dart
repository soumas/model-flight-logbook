import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';

class PilotStatusScreen extends StatefulWidget {
  const PilotStatusScreen({super.key, required this.pilotId});

  final String pilotId;

  @override
  State<PilotStatusScreen> createState() => _PilotStatusScreenState();
}

class _PilotStatusScreenState extends State<PilotStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return MflScaffold(child1: Placeholder(), showBackgroundImage: false);
  }
}
