import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';

class EndpointList extends StatelessWidget {
  const EndpointList({super.key, required this.rowBuilder});

  final Widget Function(BuildContext context, Endpoint endpoint) rowBuilder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: injector.get<GlobalEndpointsListState>().endpoints,
      builder: (context, value, child) {
        final endpoints = value.toList()..sort((a, b) => a.title.compareTo(b.title));
        return Column(children: endpoints.map((endpoint) => rowBuilder(context, endpoint)).toList());
      },
    );
  }
}
