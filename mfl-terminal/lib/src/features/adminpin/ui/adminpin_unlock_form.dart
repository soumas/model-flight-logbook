import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/adminpin/ui/adminpin_unlocked_state.dart';
import 'package:provider/provider.dart';

class AdminpinUnlockForm extends StatelessWidget {
  const AdminpinUnlockForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminpinUnlockedState>(
      builder: (context, adminpinState, child) {
        return TextFormField(onChanged: (value) => adminpinState.unlock(value));
      },
    );
  }
}
