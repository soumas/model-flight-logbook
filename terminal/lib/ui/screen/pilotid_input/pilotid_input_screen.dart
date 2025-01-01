import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/fragments/main_menu.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/fragments/pilotid_input_view.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class PilotidInputScreen extends StatefulWidget {
  const PilotidInputScreen({
    super.key,
  });

  static const route = '/';

  @override
  State<PilotidInputScreen> createState() => _PilotidInputScreenState();
}

class _PilotidInputScreenState extends State<PilotidInputScreen> {
  var _input = '';

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent && (ModalRoute.of(context)?.isCurrent ?? false)) {
      if (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        final input = _input;
        _input = '';
        Navigator.of(context).pushNamed(PilotStatusScreen.route, arguments: input);
      } else {
        _input += event.character ?? '';
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PilotidInputCubit>(
      create: (context) => injector.get<PilotidInputCubit>()..init(),
      child: Builder(builder: (context) {
        return const MflScaffold(
          title: 'Flugbuch',
          endDrawer: MainMenu(),
          child: PilotidInputView(),
        );
      }),
    );
  }
}
