import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/formvalidator.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/add_endpoint_form_backing.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class ServerUrlField extends StatelessWidget {
  const ServerUrlField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AddEndpointFormBacking>().serverurl;
    return TextFormField(
      decoration: InputDecoration(labelText: AppLocalizations.of(context)!.endpointFormFieldServerUrl),
      initialValue: state.value,
      onChanged: (value) => state.value = value,
      validator: FormValidator(context).required().url().build(),
    );
  }
}
