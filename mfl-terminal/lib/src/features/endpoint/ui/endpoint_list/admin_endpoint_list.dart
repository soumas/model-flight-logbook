import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/endpoint_list.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:provider/provider.dart';

class AdminEndpointList extends StatelessWidget {
  const AdminEndpointList({super.key});

  @override
  Widget build(BuildContext context) {
    return EndpointList(
      rowBuilder: (context, endpoint) {
        return ListTile(
          title: Text(endpoint.title),
          leading: IconButton(
            onPressed: () {
              context.read<GlobalEndpointsListState>().deleteEndpoint(endpoint);
            },
            icon: Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
