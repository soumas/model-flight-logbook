import 'package:mfl_terminal/src/common/utils/storage.dart';
import 'package:mfl_terminal/src/features/adminpin/data/dtos/adminpin_dto.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/entities/adminpin.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/repos/adminpin_repo.dart';

class AdminpinRepoImpl extends AdminpinRepo {
  final _storageKey = 'adminpin';

  @override
  Future<Adminpin?> getAdminpin() async {
    String? adminPin = await storage.read(key: _storageKey);
    if (adminPin != null) {
      return AdminpinDtoMapper.fromJson(adminPin).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<void> setAdminpin(Adminpin? adminpin) async {
    if (adminpin != null) {
      await storage.write(key: _storageKey, value: AdminpinDto.fromEntity(adminpin).toJson());
    } else {
      await storage.delete(key: _storageKey);
    }
  }
}
