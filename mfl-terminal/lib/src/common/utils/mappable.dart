import 'package:dart_mappable/dart_mappable.dart';

const mappableEntity = MappableClass(generateMethods: GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy);

const mappableDto = MappableClass(
  generateMethods: GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.encode | GenerateMethods.decode,
);
