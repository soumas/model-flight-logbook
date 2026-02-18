import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/entities/adminpin.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/repos/adminpin_repo.dart';

class AdminpinUpdateFormBacking {
  final ValueNotifier<String?> pin = ValueNotifier(null);

  Future<void> init() async {
    Adminpin? adminpin = await injector.get<AdminpinRepo>().getAdminpin();
    pin.value = adminpin?.pin;
  }

  Future<void> save() {
    return injector.get<AdminpinRepo>().setAdminpin((pin.value ?? '').isNotEmpty ? Adminpin(pin: pin.value!) : null);
  }
}
