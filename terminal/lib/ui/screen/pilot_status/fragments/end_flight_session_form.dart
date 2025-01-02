import 'package:flutter/material.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/domain/entities/end_flight_session_data.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';
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
  final _data = EndFlightSessionData(takeoffcount: 1, airspaceObserver: false, maxAltitude: 119, comment: '');
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _commentTextEditingController;
  late final TextEditingController _numFlightsEditingController;
  late final TextEditingController _maxAltitudeEditingController;
  var _luftraumbeobachter = false;

  @override
  void initState() {
    super.initState();
    _commentTextEditingController = TextEditingController(text: _data.comment.toString());
    _numFlightsEditingController = TextEditingController(text: _data.takeoffcount.toString());
    _maxAltitudeEditingController = TextEditingController(text: _data.maxAltitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      title: 'Flugtag beenden',
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Protokoll zum Flugtag',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            MflPaddings.verticalSmall(context),
            MflTextFormField(
              label: 'Flüge*',
              description: 'Gesamtanzahl der durchgeführten Flüge',
              controller: _numFlightsEditingController,
              inputType: VirtualKeyboardType.Numeric,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Dieses Feld darf nicht leer bleiben';
                } else if (int.tryParse(value!) == null) {
                  return 'Bitte geben Sie eine Ganzzahl ein.';
                }
                return null;
              },
            ),
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
                }
                return null;
              },
            ),
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
}
