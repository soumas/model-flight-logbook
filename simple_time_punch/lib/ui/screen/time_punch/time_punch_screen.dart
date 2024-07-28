import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_time_punch/constants.dart';
import 'package:simple_time_punch/ui/screen/time_punch/fragments/main_menu.dart';

class TimePunchScreen extends StatefulWidget {
  const TimePunchScreen({
    super.key,
  });

  static const route = '/';

  @override
  State<TimePunchScreen> createState() => _TimePunchScreenState();
}

class _TimePunchScreenState extends State<TimePunchScreen> {
  var _input = '';
  var _lastInput = '';

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
      _input += event.character!;
      if ((event.character ?? '') == '\r') {
        _lastInput = _input;
        _input = '';
        debugPrint(_input);
        setState(() {
          // update ui
        });
        _input = '';
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MainMenu(),
      body: Stack(
        children: [
          Center(
              child: Text(
            _lastInput,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 30,
            ),
          )),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(kAssetRfidIconWhite),
            ),
          ),
        ],
      ),
    );
  }
}
