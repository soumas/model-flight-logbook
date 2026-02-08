import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';

class FormValidator {
  FormValidator(this.context);

  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  static final RegExp _urlRegExp = RegExp(r'https?:\/\/([a-z0-9\-\_]+\.?)+[a-z0-9]{2,}(:\d+)?(\/\S*)?');

  final BuildContext context;
  final List<String? Function(String? value)> validations = [];

  FormValidator add(String? Function(String? value) validator) {
    validations.add(validator);
    return this;
  }

  String? test(String? value) {
    for (var validate in validations) {
      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  String? Function(String? value) build() => test;

  FormValidator required([String? message]) =>
      add((v) => v != null && v.isNotEmpty ? null : message ?? AppLocalizations.of(context)!.validationRequired);

  FormValidator match(String? otherValue, [String? message]) =>
      add((v) => v == otherValue ? null : message ?? AppLocalizations.of(context)!.validationNoMatch);

  FormValidator minLength(int minLength, [String? message]) =>
      add((v) => v!.length < minLength ? message ?? AppLocalizations.of(context)!.validationMinLength(minLength) : null);

  FormValidator maxLength(int maxLength, [String? message]) =>
      add((v) => v!.length > maxLength ? message ?? AppLocalizations.of(context)!.validationMaxLength(maxLength) : null);

  FormValidator regExp(RegExp regExp, String message) => add((v) => regExp.hasMatch(v!) ? null : message);

  FormValidator email([String? message]) =>
      add((v) => _emailRegExp.hasMatch(v!) ? null : message ?? AppLocalizations.of(context)!.validationEmail);

  FormValidator url([String? message]) =>
      add((v) => _urlRegExp.hasMatch(v!) ? null : message ?? AppLocalizations.of(context)!.validationUrl);
}
