import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/adminpin/ui/adminpin_update_form_backing.dart';
import 'package:provider/provider.dart';

class AdminpinUpdateForm extends StatelessWidget {
  const AdminpinUpdateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AdminpinUpdateFormBacking>(
      create: (BuildContext context) => AdminpinUpdateFormBacking()..init(),
      child: Consumer<AdminpinUpdateFormBacking>(
        builder: (BuildContext context, AdminpinUpdateFormBacking value, Widget? child) {
          return ValueListenableBuilder(
            valueListenable: value.pin,
            builder: (context, value, child) {
              return Column(
                children: [
                  TextFormField(
                    onChanged: (value) => context.read<AdminpinUpdateFormBacking>().pin.value = value,
                    initialValue: context.read<AdminpinUpdateFormBacking>().pin.value,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AdminpinUpdateFormBacking>().save();
                    },
                    label: Text('Pin speichern'),
                    icon: Icon(Icons.save),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
