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
      appBar: (title != null) ? AppBar(title: Text(title!)) : null,
      body: Builder(builder: (context) {
        return Stack(
          children: [
            if (endDrawer != null)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: () => Scaffold.of(context).openEndDrawer(), icon: const Icon(Icons.menu)),
              ),
            Center(
              child: SizedBox(
                width: 460,
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: Align(
                  alignment: alignment,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      endDrawer: endDrawer,
    );
  }
}
