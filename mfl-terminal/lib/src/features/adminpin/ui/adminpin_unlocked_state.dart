import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/entities/adminpin.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/repos/adminpin_repo.dart';

class AdminpinUnlockedState extends ValueNotifier<bool> {
  AdminpinUnlockedState() : super(false);

  Adminpin? _adminpin;

  Future<void> init() async {
    _adminpin = await injector.get<AdminpinRepo>().getAdminpin();
    value = _adminpin == null;
  }

  void unlock(String value) {
    this.value = this.value || (_adminpin?.pin ?? '') == value;
  }
}
