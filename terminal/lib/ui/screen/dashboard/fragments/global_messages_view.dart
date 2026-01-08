import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfl_terminal/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:mfl_terminal/ui/widgets/messages_column.dart';

class GlobalMessagesView extends StatelessWidget {
  const GlobalMessagesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    return MessagesColumn(
      errorMessages: state.terminalStatus?.errorMessages ?? [],
      warnMessages: state.terminalStatus?.warnMessages ?? [],
      infoMessages: state.terminalStatus?.infoMessages ?? [],
    );
  }
}
