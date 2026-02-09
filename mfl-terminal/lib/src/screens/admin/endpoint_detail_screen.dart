import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/endpoint_form.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';

class EndpointDetailScreen extends StatelessWidget {
  const EndpointDetailScreen({super.key});

  static const route = '/settings/endpoint_detail';

  @override
  Widget build(BuildContext context) {
    final entity = ModalRoute.of(context)!.settings.arguments as Endpoint?;
    return MflScaffold(
      showBackgroundImage: false,
      title: entity != null ? AppLocalizations.of(context)!.settingsEditEndpoint : AppLocalizations.of(context)!.settingsAddEndpoint,
      child1: EndpointForm(entity: entity),
    );
  }
}
