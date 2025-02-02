import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/utils/mfl_keyboard_layouts.dart';
import 'package:model_flight_logbook/ui/widgets/input_description_button.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class MflTextFormField extends StatelessWidget {
  const MflTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = VirtualKeyboardType.Alphanumeric,
    this.validator,
    this.initialValue,
    this.readOnly = false,
    this.onClose,
    this.obscureText = false,
    this.padding = kFormFieldPadding,
    this.description,
  });

  final TextEditingController controller;
  final String label;
  final VirtualKeyboardType inputType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final bool readOnly;
  final Function()? onClose;
  final bool obscureText;
  final EdgeInsets padding;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ExcludeFocus(
        excluding: readOnly || _useVirtualKeyboard,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            disabledBorder: InputBorder.none,
            suffixIcon: description != null ? InputDescriptionButton(description: description) : null,
          ),
          dragStartBehavior: DragStartBehavior.down,
          controller: controller,
          readOnly: readOnly || _useVirtualKeyboard,
          validator: validator,
          initialValue: initialValue,
          obscureText: obscureText,
          onEditingComplete: !_useVirtualKeyboard ? onClose : null,
          onTap: _useVirtualKeyboard && !readOnly
              ? () {
                  showModalBottomSheet(
                    constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width),
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.black,
                    builder: (context) {
                      return Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    filled: true,
                                    labelText: label,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('⏎')),
                                    ),
                                  ),
                                  autofocus: true,
                                ),
                              ),
                            ),
                          ),
                          VirtualKeyboard(
                            height: MediaQuery.of(context).size.height * 0.75,
                            width: MediaQuery.of(context).size.width * 0.95,
                            textColor: Colors.white,
                            textController: controller,
                            type: inputType,
                            customLayoutKeys: MflKeyboardLayouts(),
                            fontSize: MediaQuery.of(context).size.height * 0.08,
                          ),
                        ],
                      );
                    },
                  ).then(
                    (value) {
                      if (onClose != null) {
                        onClose!.call();
                      }
                    },
                  );
                }
              : null,
        ),
      ),
    );
  }

  bool get _useVirtualKeyboard => kIsWeb || (defaultTargetPlatform != TargetPlatform.iOS && defaultTargetPlatform != TargetPlatform.android);
}
