import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/exception_util.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/utils/mfl_theme.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/endpoint_form_backing.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/title_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/server_url_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/terminal_id_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/api_key_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
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
              const TitleField(),
              const ServerUrlField(),
              const TerminalIdField(),
              const ApiKeyField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final validEndpoint = _buildEndpointFromForm(context);
                      if (validEndpoint != null) {
                        bool doSave = true;
                        try {
                          await injector.get<GlobalEndpointsListState>().ping(validEndpoint);
                        } catch (e) {
                          if (context.mounted) {
                            doSave = await _askUserIfSaveAnyway(context, e);
                          }
                        }
                        if (doSave) {
                          await injector.get<GlobalEndpointsListState>().addOrUpdate(validEndpoint);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    },
                    child: Text(entity == null ? AppLocalizations.of(context)!.add : AppLocalizations.of(context)!.save),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Endpoint? _buildEndpointFromForm(BuildContext context) {
    final backing = context.read<EndpointFormBacking>();
    if (backing.formKey.currentState!.validate()) {
      return Endpoint(
        id: backing.currentEditID ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: backing.title.value,
        serverurl: backing.serverurl.value,
        terminalid: backing.terminalid.value,
        apikey: backing.apikey.value,
      );
    }
    return null;
  }

  Future<bool> _askUserIfSaveAnyway(BuildContext context, dynamic error) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.error, color: kColorError),
                SizedBox(width: 8),
                Text(ExceptionUtil.getUiMessage(context, error)),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(AppLocalizations.of(context)!.cancel)),
              TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(AppLocalizations.of(context)!.saveAnyway)),
            ],
          ),
        )) ??
        false;
  }
}
