import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/formvalidator.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_text_form_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/endpoint_form_backing.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class ServerUrlField extends StatelessWidget {
  const ServerUrlField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<EndpointFormBacking>().serverurl;
    return MflTextFormField(
      label: AppLocalizations.of(context)!.endpointFormFieldServerUrl,
      value: state,
      onAccept: (value) => state.value = value,
      validator: FormValidator(context).required().url().build(),
      readOnly: !context.read<EndpointFormBacking>().isCreate,
    );
  }
}
