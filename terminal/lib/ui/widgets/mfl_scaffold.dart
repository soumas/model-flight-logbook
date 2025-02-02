import 'package:flutter/material.dart';

class MflScaffold extends StatefulWidget {
  const MflScaffold({
    super.key,
    this.title,
    required this.child,
    this.endDrawer,
  });

  final String? title;
  final Widget child;
  final Widget? endDrawer;

  @override
  State<MflScaffold> createState() => _MflScaffoldState();
}

class _MflScaffoldState extends State<MflScaffold> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title != null ? Text(widget.title!) : null,
      ),
      body: Builder(builder: (context) {
        return RawScrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            hitTestBehavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: widget.child,
            ),
          ),
        );
      }),
      endDrawer: widget.endDrawer,
    );
  }
}
