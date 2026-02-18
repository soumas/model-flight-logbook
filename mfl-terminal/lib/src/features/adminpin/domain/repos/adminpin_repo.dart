import 'package:mfl_terminal/src/features/adminpin/domain/entities/adminpin.dart';

abstract class AdminpinRepo {
  Future<Adminpin?> getAdminpin();
  Future<void> setAdminpin(Adminpin? adminpin);
}
