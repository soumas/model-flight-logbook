import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';

class InputDescriptionButton extends StatelessWidget {
  const InputDescriptionButton({super.key, required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(description!),
                actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.close))],
              );
            },
          );
        },
        icon: const Icon(Icons.info_outline, size: 30),
      ),
    );
  }
}
