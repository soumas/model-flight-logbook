import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/utils/mfl_keyboard_layouts.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class MflTextFormField extends StatelessWidget {
  const MflTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = VirtualKeyboardType.Alphanumeric,
    this.validator,
    this.initialValue,
    this.suffixIcon,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String label;
  final VirtualKeyboardType inputType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      readOnly: readOnly || _useVirtualKeyboard,
      validator: validator,
      initialValue: initialValue,
      onTap: _useVirtualKeyboard && !readOnly
          ? () {
              showModalBottomSheet(
                constraints: const BoxConstraints.expand(width: kContentWidth),
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.black,
                builder: (context) {
                  return Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(labelText: label),
                            autofocus: true,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        color: Colors.deepPurple,
                        child: VirtualKeyboard(
                          height: 180,
                          width: kContentWidth,
                          textColor: Colors.white,
                          textController: controller,
                          type: inputType,
                          customLayoutKeys: MflKeyboardLayouts(),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: TextButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            label: const Text('Schließen'),
                            icon: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          : null,
    );
  }

  bool get _useVirtualKeyboard => defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android;
}
