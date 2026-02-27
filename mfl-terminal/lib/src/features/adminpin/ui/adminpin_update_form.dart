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
                onChanged: (value) => context.read<AdminpinUpdateFormBacking>().pin.value = value,
                value: context.read<AdminpinUpdateFormBacking>().pin,
                obscureText: true,
                description: AppLocalizations.of(context)!.settingsAdminpinText,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await context.read<AdminpinUpdateFormBacking>().save();
                    if (context.mounted) Toast.success(context: context, message: AppLocalizations.of(context)!.saveSuccess);
                  },
                  label: Text(AppLocalizations.of(context)!.save),
                  icon: Icon(Icons.save),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
