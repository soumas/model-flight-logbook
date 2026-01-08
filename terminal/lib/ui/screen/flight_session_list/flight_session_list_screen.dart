import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfl_terminal/domain/entities/flight_session.dart';
import 'package:mfl_terminal/injector.dart';
import 'package:mfl_terminal/ui/screen/flight_session_list/cubit/flight_session_list_cubit.dart';
import 'package:mfl_terminal/ui/screen/flight_session_list/cubit/flight_session_list_state.dart';
import 'package:mfl_terminal/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:mfl_terminal/ui/utils/mfl_paddings.dart';
import 'package:mfl_terminal/ui/widgets/flight_session_status_info_widget.dart';
import 'package:mfl_terminal/ui/widgets/mfl_scaffold.dart';

class PilotLogbookScreen extends StatefulWidget {
  const PilotLogbookScreen({
    super.key,
    required this.state,
  });

  final PilotStatusState state;

  @override
  State<PilotLogbookScreen> createState() => _PilotLogbookScreenState();
}

class _PilotLogbookScreenState extends State<PilotLogbookScreen> {
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector.get<FlightSessionListCubit>()..load(year: selectedYear, pilotId: widget.state.pilotid),
      child: BlocBuilder<FlightSessionListCubit, FlightSessionListState>(
        builder: (context, state) {
          return MflScaffold(
            showBackgroundImage: true,
            child1: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text('Flugbuch:  ', style: Theme.of(context).textTheme.bodyLarge),
                    DropdownButton<int>(
                      isDense: true,
                      value: selectedYear,
                      style: Theme.of(context).textTheme.bodyLarge,
                      items: List.generate(DateTime.now().year - 2025 + 1, (index) => DateTime.now().year - index)
                          .map((year) => DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value ?? DateTime.now().year;
                          context.read<FlightSessionListCubit>().load(year: selectedYear, pilotId: widget.state.pilotid);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: MflPaddings.verticalSmallSize(context)),
                if (!state.loading)
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    child: DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 10,
                      columns: [
                        DataColumn(label: Text('Datum', style: Theme.of(context).textTheme.bodyMedium)),
                        DataColumn(label: Text('Uhrzeit', style: Theme.of(context).textTheme.bodyMedium)),
                        DataColumn(
                            label: Text('Flüge', style: Theme.of(context).textTheme.bodyMedium),
                            headingRowAlignment: MainAxisAlignment.center),
                        const DataColumn(label: SizedBox()) /* icons column */,
                        const DataColumn(label: SizedBox()) /* chevron column */,
                      ],
                      rows: state.flightSessions.map((session) {
                        return DataRow(
                          onSelectChanged: (value) {
                            _showRowDetail(context, session);
                          },
                          cells: [
                            DataCell(Text(DateFormat('dd.MM.yyyy').format(session.start))),
                            DataCell(Text(
                                '${DateFormat('HH:mm').format(session.start)} - ${session.end != null ? DateFormat('HH:mm').format(session.end!) : 'aktiv'}')),
                            DataCell(Center(child: Text(session.takeoffcount?.toString() ?? ''))),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (session.comment?.isNotEmpty ?? false) const Icon(Icons.warning_outlined),
                                //if (session.comment?.isNotEmpty ?? false) const Icon(Icons.info_outline)
                              ],
                            )),
                            const DataCell(Align(alignment: Alignment.centerRight, child: Icon(Icons.chevron_right_rounded)))
                          ],
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
            child2: Column(
              children: [
                FlightSessionStatusInfoWidget(pilotStatus: widget.state.flightSessionStatus),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Flugbuch $selectedYear an deine E-Mail Adresse senden?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Abbrechen'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Senden'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    label: const Text('Senden'),
                    icon: const Icon(Icons.send),
                  ),
                ),
                SizedBox(height: MflPaddings.verticalMediumSize(context)),
                const Divider(),
                SizedBox(height: MflPaddings.verticalMediumSize(context)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    label: const Text('Schließen'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _showRowDetail(BuildContext context, FlightSession session) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(200),
                  1: FlexColumnWidth(),
                },
                children: [
                  TableRow(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text('Datum:')),
                      Text(DateFormat('dd.MM.yyyy').format(session.start)),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text('Uhrzeit:')),
                      Text(
                          '${DateFormat('HH:mm').format(session.start)} - ${session.end != null ? DateFormat('HH:mm').format(session.end!) : 'aktiv'}')
                    ],
                  ),
                  TableRow(
                    children: [const Align(alignment: Alignment.centerLeft, child: Text('Ort:')), Text(session.airport ?? '')],
                  ),
                  TableRow(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text('Flüge:')),
                      Text(session.takeoffcount?.toString() ?? '')
                    ],
                  ),
                  TableRow(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text('Maximale Flughöhe:')),
                      Text(session.maxAltitude?.toString() ?? '')
                    ],
                  ),
                  TableRow(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text('Luftraumbeobachter:')),
                      Text('${session.airspaceObserver != null ? session.airspaceObserver! ? 'Ja' : 'Nein' : ''} ')
                    ],
                  ),
                  TableRow(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text('Besondere Ereignisse:')),
                      Text(session.comment ?? ''),
                    ],
                  ),
                  // TableRow(
                  //   children: [
                  //     Align(alignment: Alignment.centerLeft, child: Text('Persönliche Bemerkung:')),
                  //     Text(
                  //         'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.')
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Schließen'),
            ),
          ],
        );
      },
    );
  }
}
