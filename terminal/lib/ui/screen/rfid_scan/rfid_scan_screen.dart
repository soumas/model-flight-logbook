import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/screen/flight_session_status/flight_session_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_flight_logbook/ui/screen/settings/settings_screen.dart';

class RfidScanScreen extends StatefulWidget {
  const RfidScanScreen({
    super.key,
  });

  static const route = '/';

  @override
  State<RfidScanScreen> createState() => _RfidScanScreenState();
}

class _RfidScanScreenState extends State<RfidScanScreen> {
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
        Navigator.of(context).pushNamed(FlightSessionStatusScreen.route, arguments: input).then((value) {
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(SettingsScreen.route),
              icon: const Icon(Icons.miscellaneous_services),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  kAssetRfidIconSlim,
                  width: size.width * 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(
                    kAssetMflLogoSlim,
                    width: size.width * 0.06,
                  ),
                ),
                Text(
                  'Model Flight Logbook',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Modellflugplatz MSGU',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
