import 'package:flutter/material.dart';
import 'package:mfl_terminal/domain/entities/end_flight_session_data.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/domain/repositories/local_storage_repo.dart';
import 'package:mfl_terminal/injector.dart';
import 'package:mfl_terminal/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:mfl_terminal/ui/utils/mfl_paddings.dart';
import 'package:mfl_terminal/ui/utils/toast.dart';
import 'package:mfl_terminal/ui/widgets/flight_session_status_info_widget.dart';
import 'package:mfl_terminal/ui/widgets/input_description_button.dart';
import 'package:mfl_terminal/ui/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/ui/widgets/mfl_text_form_field.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class EndFlightSessionForm extends StatefulWidget {
  const EndFlightSessionForm({
    super.key,
    required this.state,
  });

  final PilotStatusState state;

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
    final state = widget.state;
    return MflScaffold(
      showBackgroundImage: true,
      child1: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Protokoll:  ', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: MflPaddings.verticalSmallSize(context)),
          Form(
            key: _formKey,
            child: Container(
              color: Theme.of(context).cardTheme.color,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MflTextFormField(
                      label: 'Anzahl Flüge*',
                      description: 'Gesamtanzahl der durchgeführten Flüge',
                      controller: _numFlightsEditingController,
                      inputType: VirtualKeyboardType.Numeric,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Dieses Feld darf nicht leer bleiben';
                        } else if (int.tryParse(value!) == null) {
                          return 'Ganzzahl erforderlich';
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
                      description:
                          'Maximale Flughöhe aller durchgeführten Flüge (in Meter)\n\nBei Flughöhen ab 120m ist ein Luftraumbeobachter einzusetzen, der selbst am Flugbetrieb nicht teilnehmen darf',
                      inputType: VirtualKeyboardType.Numeric,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Dieses Feld darf nicht leer bleiben';
                        } else if (int.tryParse(value!) == null) {
                          return 'Ganzzahl erforderlich';
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
                    MflPaddings.verticalLarge(context),
                    DropdownButtonFormField(
                      isDense: false,
                      decoration: const InputDecoration(
                        label: Text('Luftraumbeobachter'),
                        suffixIcon: InputDescriptionButton(
                          description:
                              'Bei Flughöhen ab 120m ist ein Luftraumbeobachter einzusetzen, der selbst am Flugbetrieb nicht teilnehmen darf',
                        ),
                      ),
                      initialValue: _luftraumbeobachter,
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
                      onChanged: <T>(value) {
                        _luftraumbeobachter = value;
                        _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Dieses Feld darf nicht leer bleiben';
                        } else if (value == false &&
                            int.parse(_maxAltitudeEditingController.text) > _selectedEndpoint!.config.maxAltitudeWithoutObserverM) {
                          return 'Ab ${_selectedEndpoint!.config.maxAltitudeWithoutObserverM}m ist ein Luftraumbeobachter erforderlich';
                        }
                        return null;
                      },
                    ),
                    MflPaddings.verticalLarge(context),
                    MflTextFormField(
                      controller: _commentTextEditingController,
                      label: 'Besondere Ereignisse',
                      description:
                          'z.B. Absinken auf 120m wegen Annäherung eines manntragenden Luftfahrzeuges oder Flug >25kg\n\nAngaben in diesem Feld werden ggf. an den Administrator versendet.',
                    ),
                    MflPaddings.verticalMedium(context),
                    ElevatedButton.icon(
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
                      label: const Text('Check-Out'),
                      icon: const Icon(Icons.logout),
                    ),
                    MflPaddings.verticalLarge(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      child2: Column(children: [
        FlightSessionStatusInfoWidget(pilotStatus: state.flightSessionStatus),
        Container(
          color: Theme.of(context).cardTheme.color,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Fülle das Protokoll aus um den Check-Out Vorgang abzuschließen.'),
          ),
        ),
        SizedBox(height: MflPaddings.verticalMediumSize(context)),
        const Divider(),
        SizedBox(height: MflPaddings.verticalMediumSize(context)),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            label: const Text('Abbrechen'),
          ),
        ),
      ]),
    );
  }

  void _loadSelectedEndpoint() async {
    final sep = await injector.get<LocalStorageRepo>().loadSelectedTerminalEndpoint();
    setState(() {
      _selectedEndpoint = sep;
    });
  }
}
