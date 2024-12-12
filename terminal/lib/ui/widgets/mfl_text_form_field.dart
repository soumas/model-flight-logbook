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
                  constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width),
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.black,
                  builder: (context) {
                    return Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.close),
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
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
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          color: Colors.deepPurple,
                          child: VirtualKeyboard(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width,
                            textColor: Colors.white,
                            textController: controller,
                            type: inputType,
                            customLayoutKeys: MflKeyboardLayouts(),
                            fontSize: MediaQuery.of(context).size.height * 0.04,
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

  bool get _useVirtualKeyboard => kIsWeb || (defaultTargetPlatform != TargetPlatform.iOS && defaultTargetPlatform != TargetPlatform.android);
}
