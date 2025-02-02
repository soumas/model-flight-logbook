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
  final double _scrollbarWidth = 32;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title != null ? Text(widget.title!) : null,
      ),
      body: Builder(builder: (context) {
        return Scrollbar(
          controller: _scrollController,
          thickness: _scrollbarWidth,
          trackVisibility: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16 + _scrollbarWidth),
              child: widget.child,
            ),
          ),
        );
      }),
      endDrawer: widget.endDrawer,
    );
  }
}
