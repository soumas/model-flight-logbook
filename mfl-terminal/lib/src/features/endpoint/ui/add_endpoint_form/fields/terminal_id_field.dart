import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/formvalidator.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/endpoint_form_backing.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class TerminalIdField extends StatelessWidget {
  const TerminalIdField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<EndpointFormBacking>().terminalid;
    return TextFormField(
      decoration: InputDecoration(labelText: AppLocalizations.of(context)!.endpointFormFieldTerminalId),
      initialValue: state.value,
      onChanged: (value) => state.value = value,
      validator: FormValidator(context).required().build(),
      autovalidateMode: AutovalidateMode.onUnfocus,
      enabled: context.read<EndpointFormBacking>().isCreate,
    );
  }
}
