import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/endpoint_list.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:mfl_terminal/src/screens/admin/endpoint_detail_screen.dart';
import 'package:provider/provider.dart';

class AdminEndpointList extends StatelessWidget {
  const AdminEndpointList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EndpointList(
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
                          content: Text(AppLocalizations.of(context)!.settingsDeleteEndpointConfirmation(endpoint.title)),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancel)),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.read<GlobalEndpointsListState>().delete(endpoint);
                              },
                              child: Text(AppLocalizations.of(context)!.delete),
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
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EndpointDetailScreen.route);
          },
          child: Text(AppLocalizations.of(context)!.settingsAddEndpoint),
        ),
      ],
    );
  }
}
