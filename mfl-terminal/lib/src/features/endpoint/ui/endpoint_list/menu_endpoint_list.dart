import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/endpoint_list.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_active_endpoint_state.dart';
import 'package:provider/provider.dart';

class MenuEndpointList extends StatelessWidget {
  const MenuEndpointList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: injector.get<GlobalActiveEndpointState>().activeEndpoint,
      builder: (context, value, child) {
        return EndpointList(
          rowBuilder: (context, endpoint) {
            return ListTile(
              leading: (value != null && value == endpoint)
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank),
              title: Text(endpoint.title),
              subtitle: Text(endpoint.serverurl),
              onTap: () {
                // Navigator.of(context).pop();
                context.read<GlobalActiveEndpointState>().activeEndpoint.value = endpoint;
              },
            );
          },
        );
      },
    );
  }
}
