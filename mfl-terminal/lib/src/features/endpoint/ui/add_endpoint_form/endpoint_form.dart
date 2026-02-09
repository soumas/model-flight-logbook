import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/exception_util.dart';
import 'package:mfl_terminal/src/common/utils/mfl_theme.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/endpoint_form_backing.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/title_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/server_url_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/terminal_id_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/api_key_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:provider/provider.dart';

class EndpointForm extends StatelessWidget {
  const EndpointForm({super.key, this.entity});

  final Endpoint? entity;

  @override
  Widget build(BuildContext context) {
    return Provider<EndpointFormBacking>(
      create: (BuildContext context) => EndpointFormBacking(entity: entity),
      dispose: (context, value) => value.dispose(),
      builder: (context, child) {
        return Form(
          key: context.read<EndpointFormBacking>().formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const TitleField(),
              const SizedBox(height: 16),
              const ServerUrlField(),
              const SizedBox(height: 16),
              const TerminalIdField(),
              const SizedBox(height: 16),
              const ApiKeyField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final backing = context.read<EndpointFormBacking>();
                      if (backing.formKey.currentState!.validate()) {
                        final endpoint = Endpoint(
                          title: backing.title.value,
                          serverurl: backing.serverurl.value,
                          terminalid: backing.terminalid.value,
                          apikey: backing.apikey.value,
                        );
                        await context.read<GlobalEndpointsListState>().addOrUpdate(endpoint);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text('Speichern'),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () async {
                      final backing = context.read<EndpointFormBacking>();
                      if (backing.formKey.currentState!.validate()) {
                        final endpoint = Endpoint(
                          title: backing.title.value,
                          serverurl: backing.serverurl.value,
                          terminalid: backing.terminalid.value,
                          apikey: backing.apikey.value,
                        );
                        try {
                          await context.read<GlobalEndpointsListState>().ping(endpoint);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Row(
                                children: [
                                  Icon(Icons.check, color: kColorSuccess),
                                  SizedBox(width: 8),
                                  Text('Die Verbindung konnte erfolgreich hergestellt werden.'),
                                ],
                              ),
                              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK'))],
                            ),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Row(
                                children: [
                                  Icon(Icons.error, color: kColorError),
                                  SizedBox(width: 8),
                                  Text('Fehler: ${ExceptionUtil.getUiMessage(context, e)}'),
                                ],
                              ),
                              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK'))],
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Test Connection'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
