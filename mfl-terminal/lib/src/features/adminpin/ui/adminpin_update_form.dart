import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/toast.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_text_form_field.dart';
import 'package:mfl_terminal/src/features/adminpin/ui/adminpin_update_form_backing.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class AdminpinUpdateForm extends StatelessWidget {
  const AdminpinUpdateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AdminpinUpdateFormBacking>(
      create: (BuildContext context) => AdminpinUpdateFormBacking()..init(),
      child: Consumer<AdminpinUpdateFormBacking>(
        builder: (BuildContext context, AdminpinUpdateFormBacking value, Widget? child) {
          return Column(
            children: [
              MflTextFormField(
                label: AppLocalizations.of(context)!.settingsAdminpin,
                onAccept: (value) async {
                  context.read<AdminpinUpdateFormBacking>().pin.value = value;
                  await context.read<AdminpinUpdateFormBacking>().save();
                  if (context.mounted) {
                    final msg = value.isEmpty
                        ? AppLocalizations.of(context)!.settingsAdminpinResetted
                        : AppLocalizations.of(context)!.settingsAdminpinSaved;
                    Toast.success(context: context, message: msg);
                  }
                },
                value: context.read<AdminpinUpdateFormBacking>().pin,
                obscureText: true,
                description: AppLocalizations.of(context)!.settingsAdminpinText,
              ),
            ],
          );
        },
      ),
    );
  }
}
