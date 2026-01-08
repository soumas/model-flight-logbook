import 'package:flutter/material.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/ui/utils/mfl_device_info.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';
import 'package:model_flight_logbook/ui/utils/mfl_theme.dart';

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
  final double _scrollbarWidth = 10;
  final double _outerPadding = 20;

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
          color: widget.showBackgroundImage ? null : kColorBackground,
        ),
        if (widget.showBackgroundImage)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Opacity(
                opacity: 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      kAssetMflLogoSlim,
                      height: 40,
                    ),
                    SizedBox(height: MflPaddings.verticalSmallSize(context)),
                    const VersionNumberWidget()
                  ],
                ),
              ),
            ),
          ),
        Scaffold(
          appBar: widget.showBackgroundImage
              ? null
              : AppBar(
                  title: widget.title != null ? Text(widget.title!) : null,
                ),
          body: Stack(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                if (MediaQuery.of(context).size.width >= 768) {
                  final twoCols = widget.child2 != null;
                  return Row(
                    children: _buildContainer(constraints: constraints, child: widget.child1, width: twoCols ? 0.65 : null)
                      ..addAll(_buildContainer(constraints: constraints, child: widget.child2, width: twoCols ? 0.35 : null)),
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
              if (widget.endDrawer != null) const MenuButton(),
            ],
          ),
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
    final colwidth = constraints.maxWidth * (width ?? 1);
    result.add(
      SizedBox(
        width: colwidth,
        height: constraints.maxHeight,
        child: RawScrollbar(
          controller: sc,
          thickness: _scrollbarWidth,
          thumbVisibility: true,
          thumbColor: Colors.grey.shade700,
          radius: const Radius.circular(4),
          child: SingleChildScrollView(
            controller: sc,
            child: Padding(
              padding: EdgeInsets.only(
                  top: widget.showBackgroundImage ? _outerPadding * 2 : 0,
                  bottom: widget.showBackgroundImage ? _outerPadding * 2 : 0,
                  left: colwidth < 0.5 ? 0 : _outerPadding,
                  right: _outerPadding + _scrollbarWidth),
              child: child,
            ),
          ),
        ),
      ),
    );

    return result;
  }
}

class VersionNumberWidget extends StatelessWidget {
  const VersionNumberWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Model Flight Logbook\nVersion: ${injector.get<MflDeviceInfo>().version}',
      style: Theme.of(context).textTheme.labelSmall,
      textAlign: TextAlign.center,
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 10,
      right: 10,
      child: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
      ),
    );
  }
}
