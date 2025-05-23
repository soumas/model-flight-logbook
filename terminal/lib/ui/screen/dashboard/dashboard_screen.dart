import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/fragments/dashboard_view.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  static const route = '/';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => injector.get<DashboardCubit>()..init(),
      child: Builder(builder: (context) {
        return const DashboardView();
      }),
    );
  }
}
