import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/endpoint_list.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:mfl_terminal/src/screens/admin/endpoint_detail_screen.dart';
import 'package:provider/provider.dart';

class AdminEndpointList extends StatelessWidget {
  const AdminEndpointList({super.key});

  @override
  Widget build(BuildContext context) {
    return EndpointList(
      rowBuilder: (context, endpoint) {
        return ListTile(
          title: Text(endpoint.title),
          subtitle: Text('${endpoint.serverurl}, ${endpoint.terminalid}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Löschen bestätigen'),
                      content: Text('Möchten Sie die Verbindung "${endpoint.title}" wirklich löschen?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Abbrechen')),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.read<GlobalEndpointsListState>().delete(endpoint);
                          },
                          child: Text('Löschen'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EndpointDetailScreen.route, arguments: endpoint);
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        );
      },
    );
  }
}
