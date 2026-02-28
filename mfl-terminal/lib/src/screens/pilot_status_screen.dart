import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';

class PilotStatusScreen extends StatefulWidget {
  const PilotStatusScreen({super.key, required this.pilotId});

  final String pilotId;

  @override
  State<PilotStatusScreen> createState() => _PilotStatusScreenState();
}

class _PilotStatusScreenState extends State<PilotStatusScreen> {
  static const int _autoCloseDurationSeconds = 30;
  int _autoCloseRemainingSeconds = _autoCloseDurationSeconds;
  late Timer _autoCloseTimer;

  @override
  void initState() {
    super.initState();
    _autoCloseTimer = Timer.periodic(Duration(seconds: 1), _handleAutoCloseTimerTick);
  }

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      child1: ElevatedButton(onPressed: Navigator.of(context).pop, child: Text('test')),
      child2: LinearProgressIndicator(value: 1 / _autoCloseDurationSeconds * _autoCloseRemainingSeconds),
    );
  }

  @override
  void dispose() {
    _autoCloseTimer.cancel();
    super.dispose();
  }

  void _handleAutoCloseTimerTick(Timer timer) {
    setState(() {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        _autoCloseRemainingSeconds--;
      } else {
        _autoCloseRemainingSeconds = _autoCloseDurationSeconds;
      }
    });
    if (_autoCloseRemainingSeconds <= 0) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
