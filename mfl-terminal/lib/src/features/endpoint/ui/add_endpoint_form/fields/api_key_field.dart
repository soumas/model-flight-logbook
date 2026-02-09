import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/formvalidator.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/endpoint_form_backing.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class ApiKeyField extends StatefulWidget {
  const ApiKeyField({super.key});

  @override
  State<ApiKeyField> createState() => _ApiKeyFieldState();
}

class _ApiKeyFieldState extends State<ApiKeyField> {
  var _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final state = context.read<EndpointFormBacking>().apikey;
    return TextFormField(
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.endpointFormFieldApiKey,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      initialValue: state.value,
      onChanged: (value) => state.value = value,
      obscureText: _obscureText,
      validator: FormValidator(context).required().build(),
      autovalidateMode: AutovalidateMode.onUnfocus,
    );
  }
}
