import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/domain/entities/end_flight_session_data.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';
import 'package:model_flight_logbook/ui/utils/toast.dart';
import 'package:model_flight_logbook/ui/widgets/input_description_button.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_text_form_field.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class EndFlightSessionForm extends StatefulWidget {
  const EndFlightSessionForm({super.key});

  static const route = '/end_flight_session';

  @override
  State<EndFlightSessionForm> createState() => _EndFlightSessionFormState();
}

class _EndFlightSessionFormState extends State<EndFlightSessionForm> {
  final _data = EndFlightSessionData(takeoffcount: 0, airspaceObserver: false, maxAltitude: 119, comment: '');
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _commentTextEditingController;
  late final TextEditingController _numFlightsEditingController;
  late final TextEditingController _maxAltitudeEditingController;
  var _luftraumbeobachter = false;
  TerminalEndpoint? _selectedEndpoint;

  @override
  void initState() {
    super.initState();
    _commentTextEditingController = TextEditingController(text: _data.comment.toString());
    _numFlightsEditingController = TextEditingController(text: _data.takeoffcount > 0 ? _data.takeoffcount.toString() : null);
    _maxAltitudeEditingController = TextEditingController(text: _data.maxAltitude.toString());
    _loadSelectedEndpoint();
  }

  @override
  void dispose() {
    _commentTextEditingController.dispose();
    _numFlightsEditingController.dispose();
    _maxAltitudeEditingController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)!.settings.arguments as PilotStatusState;
    return MflScaffold(
      title: 'Protokoll zum Flugtag',
      child1: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MflPaddings.verticalSmall(context),
            Align(alignment: Alignment.centerLeft, child: Text(state.flightSessionStatus!.pilotName, style: Theme.of(context).textTheme.headlineLarge)),
            Align(alignment: Alignment.centerLeft, child: Text('Startzeit: ${DateFormat.Hm().format(state.flightSessionStatus!.sessionStarttime!)} Uhr', style: Theme.of(context).textTheme.bodyMedium)),
            MflPaddings.verticalSmall(context),
            MflTextFormField(
              label: 'Anzahl Flüge*',
              description: 'Gesamtanzahl der durchgeführten Flüge',
              controller: _numFlightsEditingController,
              inputType: VirtualKeyboardType.Numeric,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Dieses Feld darf nicht leer bleiben';
                } else if (int.tryParse(value!) == null) {
                  return 'Bitte geben Sie eine Ganzzahl ein.';
                } else if (int.parse(value) < 0) {
                  return 'Kleinster Wert: 0';
                } else if (int.parse(value) > _selectedEndpoint!.config.maxNumFlights) {
                  return 'Maximalwert: ${_selectedEndpoint!.config.maxNumFlights}';
                }
                return null;
              },
              onClose: () {
                _formKey.currentState!.validate();
              },
            ),
            MflPaddings.verticalSmall(context),
            MflTextFormField(
              controller: _maxAltitudeEditingController,
              label: 'Maximale Flughöhe (m)*',
              description: 'Maximale Flughöhe aller durchgeführten Flüge (in Meter)\n\nBei Flughöhen ab 120m ist ein Luftraumbeobachter einzusetzen, der selbst am Flugbetrieb nicht teilnehmen darf',
              inputType: VirtualKeyboardType.Numeric,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Dieses Feld darf nicht leer bleiben';
                } else if (int.tryParse(value!) == null) {
                  return 'Bitte geben Sie eine Ganzzahl ein.';
                } else if (int.parse(value) < 0) {
                  return 'Kleinster Wert: 0';
                } else if (int.parse(value) > _selectedEndpoint!.config.maxAltitudeM) {
                  return 'Maximalwert: ${_selectedEndpoint!.config.maxAltitudeM}';
                }
                return null;
              },
              onClose: () {
                _formKey.currentState!.validate();
              },
            ),
            MflPaddings.verticalSmall(context),
            DropdownButtonFormField(
              isDense: false,
              decoration: const InputDecoration(
                label: Text('Luftraumbeobachter'),
                suffixIcon: InputDescriptionButton(
                  description: 'Bei Flughöhen ab 120m ist ein Luftraumbeobachter einzusetzen, der selbst am Flugbetrieb nicht teilnehmen darf',
                ),
              ),
              padding: kFormFieldPadding,
              value: _luftraumbeobachter,
              items: [
                DropdownMenuItem(
                  value: false,
                  child: Text(
                    'Nein',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                DropdownMenuItem(
                  value: true,
                  child: Text(
                    'Ja',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
              onChanged: <bool>(value) {
                _luftraumbeobachter = value;
              },
              dropdownColor: Colors.blueGrey,
            ),
            MflPaddings.verticalSmall(context),
            MflTextFormField(
              controller: _commentTextEditingController,
              label: 'Besondere Ereignisse',
              description: 'z.B. Absinken auf 120m wegen Annäherung eines manntragenden Luftfahrzeuges oder Flug >25kg\n\nAngaben in diesem Feld werden ggf. an den Administrator versendet.',
            ),
            MflPaddings.verticalMedium(context),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop(
                    _data.copyWith(
                      takeoffcount: int.parse(_numFlightsEditingController.text),
                      airspaceObserver: _luftraumbeobachter,
                      comment: _commentTextEditingController.text,
                      maxAltitude: int.parse(_maxAltitudeEditingController.text),
                    ),
                  );
                } else {
                  Toast.error(context: context, message: 'Formular enthält Fehler');
                }
              },
              child: const Text('Absenden'),
            ),
            MflPaddings.verticalLarge(context),
          ],
        ),
      ),
    );
  }

  void _loadSelectedEndpoint() async {
    final sep = await injector.get<LocalStorageRepo>().loadSelectedTerminalEndpoint();
    setState(() {
      _selectedEndpoint = sep;
    });
  }
}
