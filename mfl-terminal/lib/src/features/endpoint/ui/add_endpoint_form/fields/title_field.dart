import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/formvalidator.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_text_form_field.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/endpoint_form_backing.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<EndpointFormBacking>().title;
    return MflTextFormField(
      label: AppLocalizations.of(context)!.endpointFormFieldTitle,
      value: state,
      onAccept: (value) => state.value = value,
      validator: FormValidator(context).required().build(),
    );
  }
}
