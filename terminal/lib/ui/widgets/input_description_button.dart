import 'package:flutter/material.dart';

class InputDescriptionButton extends StatelessWidget {
  const InputDescriptionButton({
    super.key,
    required this.description,
  });

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
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Schließen'),
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(
          Icons.info_outline,
          size: MediaQuery.of(context).size.height * 0.10,
        ),
      ),
    );
  }
}
