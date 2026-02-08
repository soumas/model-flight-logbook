import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_device_info.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';

class VersionNumberWidget extends StatelessWidget {
  const VersionNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppLocalizations.of(context)!.productname}\n${AppLocalizations.of(context)!.versiontag(MflDeviceInfo.version)}',
      style: Theme.of(context).textTheme.labelSmall,
      textAlign: TextAlign.center,
    );
  }
}
