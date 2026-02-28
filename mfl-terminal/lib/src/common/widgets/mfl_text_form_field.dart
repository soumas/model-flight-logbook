import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_keyboard_layouts.dart';
import 'package:mfl_terminal/src/common/widgets/input_description_button.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class MflTextFormField extends StatefulWidget {
  const MflTextFormField({
    super.key,
    required this.label,
    this.value,
    this.inputType = VirtualKeyboardType.Alphanumeric,
    this.validator,
    this.readOnly = false,
    this.onAccept,
    this.onCancel,
    this.obscureText = false,
    this.padding = const EdgeInsets.symmetric(vertical: 20.0),
    this.description,
  });

  final String label;
  final VirtualKeyboardType inputType;
  final FormFieldValidator<String>? validator;
  final ValueNotifier<String?>? value;
  final bool readOnly;
  final Function(String)? onAccept;
  final Function()? onCancel;
  final bool obscureText;
  final EdgeInsets padding;
  final String? description;

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
    _controller.addListener(_textboxToValue);
    widget.value?.addListener(_valueToTextbox);
  }

  void _valueToTextbox() {
    if (widget.value?.value != _controller.text) {
      _controller.text = widget.value?.value ?? '';
    }
  }

  void _textboxToValue() {
    if (widget.value?.value != _controller.text) {
      widget.value?.value = _controller.text;
    }
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
          onTap: _useVirtualKeyboard && !widget.readOnly
              ? () {
                  showModalBottomSheet(
                    constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width),
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.black,
                    builder: (context) {
                      return _ModalBottomSheetContent(
                        label: widget.label,
                        initialText: _controller.text,
                        obscureText: widget.obscureText,
                        inputType: widget.inputType,
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      _controller.text = value;
                      widget.onAccept?.call(_controller.text);
                    } else {
                      widget.onCancel?.call();
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

  @override
  void dispose() {
    _controller.dispose();
    widget.value?.removeListener(_valueToTextbox);
    super.dispose();
  }
}

class _ModalBottomSheetContent extends StatefulWidget {
  const _ModalBottomSheetContent({required this.label, required this.initialText, required this.obscureText, required this.inputType});

  final String label;
  final String initialText;
  final bool obscureText;
  final VirtualKeyboardType inputType;

  @override
  State<_ModalBottomSheetContent> createState() => _ModalBottomSheetContentState();
}

class _ModalBottomSheetContentState extends State<_ModalBottomSheetContent> {
  late final TextEditingController _controller2;
  late bool _obscureText2;

  @override
  void initState() {
    super.initState();
    _controller2 = TextEditingController(text: widget.initialText);
    _obscureText2 = widget.obscureText;
  }

  @override
  void dispose() {
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _controller2,
            obscureText: _obscureText2,
            decoration: InputDecoration(
              fillColor: Colors.black,
              filled: true,
              labelText: widget.label,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.obscureText)
                      IconButton(
                        icon: Icon(_obscureText2 ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _controller2.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            autofocus: true,
          ),
          VirtualKeyboard(
            height: 250,
            textColor: Colors.white,
            textController: _controller2,
            type: widget.inputType,
            customLayoutKeys: MflKeyboardLayouts(),
            fontSize: MediaQuery.of(context).size.height * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.of(context).pop(null), child: Text(AppLocalizations.of(context)!.cancel)),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(_controller2.text),
                  child: Text(AppLocalizations.of(context)!.takeOver),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
