import 'package:package_info_plus/package_info_plus.dart';

class MflDeviceInfo {
  late PackageInfo _packageInfo;

  void init() async {
    PackageInfo.fromPlatform().then((info) {
      _packageInfo = info;
    });
  }

  String get version => _packageInfo.version;
}
