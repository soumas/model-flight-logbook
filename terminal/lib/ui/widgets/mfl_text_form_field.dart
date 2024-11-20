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
    this.onClose,
    this.obscureText = false,
    this.padding = kFormFieldPadding,
  });

  final TextEditingController controller;
  final String label;
  final VirtualKeyboardType inputType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool readOnly;
  final Function()? onClose;
  final bool obscureText;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffixIcon,
          disabledBorder: InputBorder.none,
        ),
        controller: controller,
        readOnly: readOnly || _useVirtualKeyboard,
        validator: validator,
        initialValue: initialValue,
        obscureText: obscureText,
        onTap: _useVirtualKeyboard && !readOnly
            ? () {
                showModalBottomSheet(
                  constraints: const BoxConstraints.expand(width: kContentWidth),
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.black.withAlpha(120),
                  builder: (context) {
                    return Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: kFormFieldPadding,
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  filled: true,
                                  labelText: label,
                                  suffix: TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    label: const SizedBox(),
                                    icon: const Icon(Icons.keyboard_return),
                                    iconAlignment: IconAlignment.end,
                                  ),
                                ),
                                autofocus: true,
                              ),
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
                        const SizedBox(height: 20),
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
    );
  }

  bool get _useVirtualKeyboard => false; //kIsWeb || (defaultTargetPlatform != TargetPlatform.iOS && defaultTargetPlatform != TargetPlatform.android);
}
