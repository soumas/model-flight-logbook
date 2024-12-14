import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_text_form_field.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class EndFlightSessionButton extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _commentTextEditingController = TextEditingController();
  final _numFlightsEditingController = TextEditingController();

  EndFlightSessionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          bool confirmed = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.black,
            builder: (context) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: kFormFieldPadding,
                      child: Text(
                        'Flugbuch',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    MflTextFormField(
                      controller: _numFlightsEditingController,
                      label: 'Anzahl Flüge*',
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
                      controller: _commentTextEditingController,
                      label: 'Besondere Ereignisse',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop(true);
                        }
                      },
                      child: const Text('Absenden'),
                    ),
                  ],
                ),
              );
            },
          );

          if (confirmed && context.mounted) {
            context.read<PilotStatusCubit>().endSession(
                  numFlights: int.parse(_numFlightsEditingController.text),
                  comment: _commentTextEditingController.text.isNotEmpty ? _commentTextEditingController.text : null,
                );
          }
        },
        label: const Text('Sitzung beenden'),
        icon: const Icon(Icons.flight_land),
      ),
    );
  }
}
