import 'package:dronedpace_logbook_terminal/ui/screen/flight_session_status/flight_session_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dronedpace_logbook_terminal/constants.dart';
import 'package:dronedpace_logbook_terminal/ui/screen/rfid_scan/fragments/main_menu.dart';

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
    if (event is KeyDownEvent) {
      if ((event.character ?? '') == '\r') {
        ServicesBinding.instance.keyboard.removeHandler(_onKey);
        Navigator.of(context).pushNamed(FlightSessionStatusScreen.route, arguments: _input).then((value) {
          ServicesBinding.instance.keyboard.addHandler(_onKey);
          _input = '';
        });
      } else {
        _input += event.character!;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MainMenu(),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Image.asset(kAssetRfidIconWhite),
        ),
      ),
    );
  }
}
