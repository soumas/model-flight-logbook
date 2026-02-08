import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mfl_terminal/src/common/utils/mfl_theme.dart';

class UhrWidget extends StatefulWidget {
  const UhrWidget({super.key});

  @override
  State<UhrWidget> createState() => _UhrWidgetState();
}

class _UhrWidgetState extends State<UhrWidget> {
  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), update);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat.Hm().format(time),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 72, height: 1, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          DateFormat('EEEE, d. MMM').format(time),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kColorFontSub),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void update(Timer timer) {
    if (mounted) {
      setState(() {
        time = DateTime.now();
      });
    }
  }
}
