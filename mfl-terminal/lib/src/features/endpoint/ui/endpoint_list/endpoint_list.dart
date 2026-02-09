import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:provider/provider.dart';

class EndpointList extends StatelessWidget {
  const EndpointList({super.key, required this.rowBuilder});

  final Widget Function(BuildContext context, Endpoint endpoint) rowBuilder;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GlobalEndpointsListState>();
    return Column(children: state.endpoints.map((endpoint) => rowBuilder(context, endpoint)).toList());
  }
}
