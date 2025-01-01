import 'package:flutter/material.dart';

class MflScaffold extends StatelessWidget {
  const MflScaffold({
    super.key,
    this.title,
    required this.child,
    this.alignment = Alignment.topCenter,
    this.endDrawer,
  });

  final String? title;
  final Widget child;
  final Alignment alignment;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: child,
          ),
        );
      }),
      endDrawer: endDrawer,
    );
  }
}
