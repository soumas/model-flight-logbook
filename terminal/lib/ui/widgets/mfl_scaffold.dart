import 'package:flutter/material.dart';
import 'package:model_flight_logbook/constants.dart';

class MflScaffold extends StatefulWidget {
  const MflScaffold({
    super.key,
    this.title,
    required this.child1,
    this.child2,
    this.endDrawer,
    this.showBackgroundImage = false,
  });

  final String? title;
  final Widget child1;
  final Widget? child2;
  final Widget? endDrawer;
  final bool showBackgroundImage;

  @override
  State<MflScaffold> createState() => _MflScaffoldState();
}

class _MflScaffoldState extends State<MflScaffold> {
  final double _scrollbarWidth = 16;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: widget.showBackgroundImage
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kAssetBgImage),
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          color: widget.showBackgroundImage ? null : Colors.black,
        ),
        Scaffold(
          appBar: AppBar(
            title: widget.title != null ? Text(widget.title!) : null,
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            if (MediaQuery.of(context).size.width >= 768) {
              final twoCols = widget.child2 != null;
              return Row(
                children: _buildContainer(constraints: constraints, child: widget.child1, width: twoCols ? 0.65 : null)..addAll(_buildContainer(constraints: constraints, child: widget.child2, width: twoCols ? 0.35 : null)),
              );
            } else {
              return _buildContainer(
                  constraints: constraints,
                  child: Column(
                    children: [
                      widget.child2 ?? const SizedBox(),
                      widget.child1,
                    ],
                  ))[0];
            }
          }),
          endDrawer: widget.endDrawer,
        ),
      ],
    );
  }

  List<Widget> _buildContainer({required BoxConstraints constraints, Widget? child, num? width}) {
    final result = <Widget>[];
    if (child == null) {
      return result;
    }

    final sc = ScrollController();
    result.add(
      SizedBox(
        width: constraints.maxWidth * (width ?? 1),
        height: constraints.maxHeight,
        child: RawScrollbar(
          controller: sc,
          thickness: _scrollbarWidth,
          thumbVisibility: true,
          thumbColor: Colors.grey.shade700,
          radius: const Radius.circular(8),
          child: SingleChildScrollView(
            controller: sc,
            child: Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16 + _scrollbarWidth),
              child: child,
            ),
          ),
        ),
      ),
    );

    return result;
  }
}
