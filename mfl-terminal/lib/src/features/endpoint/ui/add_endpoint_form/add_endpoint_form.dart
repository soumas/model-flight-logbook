import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/add_endpoint_form_backing.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/title_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/server_url_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/terminal_id_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/fields/api_key_field.dart';
import 'package:provider/provider.dart';

class AddEndpointForm extends StatelessWidget {
  const AddEndpointForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddEndpointFormBacking>(
      create: (BuildContext context) => AddEndpointFormBacking(),
      builder: (context, child) {
        return Form(
          key: context.read<AddEndpointFormBacking>().formKey,
          child: Column(
            children: [
              const TitleField(),
              const ServerUrlField(),
              const TerminalIdField(),
              const ApiKeyField(),
              ElevatedButton(
                onPressed: () {
                  if (context.read<AddEndpointFormBacking>().formKey.currentState!.validate()) {
                    context.read<AddEndpointFormBacking>().submit();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
