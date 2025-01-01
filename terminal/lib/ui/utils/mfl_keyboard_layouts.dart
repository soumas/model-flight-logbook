import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class MflKeyboardLayouts extends VirtualKeyboardLayoutKeys {
  MflKeyboardLayouts();

  @override
  int getLanguagesCount() => 2;

  @override
  List<List> getLanguage(int index) {
    return index == 0 ? _german : _specialchars;
  }
}

const List<List> _german = [
  ['q', 'w', 'e', 'r', 't', 'z', 'u', 'i', 'o', 'p', 'ü', VirtualKeyboardKeyAction.Backspace],
  ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'ö', 'ä', VirtualKeyboardKeyAction.Shift],
  ['y', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', ':', '/', VirtualKeyboardKeyAction.SwithLanguage],
  [VirtualKeyboardKeyAction.Space]
];

const List<List> _specialchars = [
  ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '+', '-', VirtualKeyboardKeyAction.Backspace],
  ['*', '/', '@', ';', ',', ':', '=', '!', '"', '\$', '%', '&', ''],
  ['(', ')', '~', '#', '.', '<', '>', '|', 'ß', '§', '^', '\'', '?', '_', VirtualKeyboardKeyAction.SwithLanguage],
  [VirtualKeyboardKeyAction.Space]
];
