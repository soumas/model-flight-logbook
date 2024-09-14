import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_flight_logbook/ui/screen/settings/settings_screen.dart';

class PilotIdInputScreen extends StatefulWidget {
  const PilotIdInputScreen({
    super.key,
  });

  static const route = '/';

  @override
  State<PilotIdInputScreen> createState() => _PilotIdInputScreenState();
}

class _PilotIdInputScreenState extends State<PilotIdInputScreen> {
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
        Navigator.of(context).pushNamed(PilotStatusScreen.route, arguments: input).then((value) {
          if (value != null) {
            showAboutDialog(context: context, children: [Text(value.toString())]);
          }
        });
      } else {
        _input += event.character ?? '';
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Modellflugplatz MSGU',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'RFID Terminal',
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  kAssetRfidIconSlim,
                                  height: MediaQuery.of(context).size.height * 0.25,
                                ),
                                // if (false)
                                //   IconButton(
                                //     onPressed: () {},
                                //     icon: Icon(
                                //       Icons.keyboard,
                                //       size: MediaQuery.of(context).size.height * 0.1,
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          kAssetMflLogoSlim,
                          height: 40,
                        ),
                      ),
                      Text(
                        '"Model Flight Logbook" by MSGU',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(SettingsScreen.route),
              icon: const Icon(Icons.miscellaneous_services),
            ),
          ),
        ],
      ),
    );
  }
}
