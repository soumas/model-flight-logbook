import 'package:dart_mappable/dart_mappable.dart';

const mappableModelClass = MappableClass(
  generateMethods: GenerateMethods.all,
);
const mappableStateClass = MappableClass(
  generateMethods: GenerateMethods.copy | GenerateMethods.equals | GenerateMethods.stringify,
);
