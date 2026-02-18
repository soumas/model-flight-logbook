import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/entities/adminpin.dart';

part 'adminpin_dto.mapper.dart';

@mappableDto
class AdminpinDto with AdminpinDtoMappable {
  final String pin;

  AdminpinDto({required this.pin});

  factory AdminpinDto.fromEntity(Adminpin adminpin) {
    return AdminpinDto(pin: adminpin.pin);
  }

  Adminpin toEntity() {
    return Adminpin(pin: pin);
  }
}
