import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/toast.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_text_form_field.dart';
import 'package:mfl_terminal/src/features/adminpin/ui/adminpin_unlocked_state.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class AdminpinUnlockForm extends StatelessWidget {
  const AdminpinUnlockForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminpinUnlockedState>(
      builder: (context, adminpinState, child) {
        // settingsAdminpinSave
        return MflTextFormField(
          label: AppLocalizations.of(context)!.settingsAdminpin,
          obscureText: true,
          description: AppLocalizations.of(context)!.settingsAdminpinForgotten,
          onChanged: (value) {
            adminpinState.unlock(value);
            if (adminpinState.value != true) {
              Toast.error(context: context, message: AppLocalizations.of(context)!.settingsAdminpinInvalid);
            }
          },
        );
      },
    );
  }
}
