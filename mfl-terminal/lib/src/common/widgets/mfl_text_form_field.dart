import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_keyboard_layouts.dart';
import 'package:mfl_terminal/src/common/widgets/input_description_button.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class MflTextFormField extends StatefulWidget {
  const MflTextFormField({
    super.key,
    required this.label,
    this.value,
    this.inputType = VirtualKeyboardType.Alphanumeric,
    this.validator,
    this.readOnly = false,
    this.onClose,
    this.obscureText = false,
    this.padding = const EdgeInsets.symmetric(vertical: 20.0),
    this.description,
    this.onChanged,
  });

  final String label;
  final VirtualKeyboardType inputType;
  final FormFieldValidator<String>? validator;
  final ValueNotifier<String?>? value;
  final bool readOnly;
  final Function()? onClose;
  final bool obscureText;
  final EdgeInsets padding;
  final String? description;
  final Function(String)? onChanged;

  @override
  State<MflTextFormField> createState() => _MflTextFormFieldState();
}

class _MflTextFormFieldState extends State<MflTextFormField> {
  final TextEditingController _controller = TextEditingController();
  late bool _obscureText = widget.obscureText;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value?.value ?? '';
    _controller.addListener(() {
      if (widget.value?.value != _controller.text) {
        widget.value?.value = _controller.text;
      }
    });
    widget.value?.addListener(() {
      if (widget.value?.value != _controller.text) {
        _controller.text = widget.value?.value ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: ExcludeFocus(
        excluding: widget.readOnly || _useVirtualKeyboard,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: widget.label,
            disabledBorder: InputBorder.none,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.obscureText)
                  IconButton(
                    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                if (widget.description != null) InputDescriptionButton(description: widget.description),
              ],
            ),
          ),
          dragStartBehavior: DragStartBehavior.down,
          controller: _controller,
          readOnly: widget.readOnly || _useVirtualKeyboard,
          validator: widget.validator,
          obscureText: _obscureText,
          onEditingComplete: !_useVirtualKeyboard ? widget.onClose : null,
          onTap: _useVirtualKeyboard && !widget.readOnly
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
                                  controller: _controller,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    filled: true,
                                    labelText: widget.label,
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
                            textController: _controller,
                            type: widget.inputType,
                            customLayoutKeys: MflKeyboardLayouts(),
                            fontSize: MediaQuery.of(context).size.height * 0.08,
                          ),
                        ],
                      );
                    },
                  ).then((value) {
                    if (widget.onClose != null) {
                      widget.onClose!.call();
                    }
                    if (widget.onChanged != null) {
                      widget.onChanged!(_controller.text);
                    }
                  });
                }
              : null,
        ),
      ),
    );
  }

  bool get _useVirtualKeyboard =>
      kIsWeb || (defaultTargetPlatform != TargetPlatform.iOS && defaultTargetPlatform != TargetPlatform.android);
}
