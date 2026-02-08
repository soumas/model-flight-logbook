import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/formvalidator.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/add_endpoint_form_backing.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class TerminalIdField extends StatelessWidget {
  const TerminalIdField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AddEndpointFormBacking>().terminalid;
    return TextFormField(
      decoration: InputDecoration(labelText: AppLocalizations.of(context)!.endpointFormFieldTerminalId),
      initialValue: state.value,
      onChanged: (value) => state.value = value,
      validator: FormValidator(context).required().build(),
    );
  }
}
