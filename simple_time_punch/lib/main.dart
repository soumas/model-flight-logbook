import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_time_punch/ui/screen/time_punch/time_punch_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const TimePunchScreen(),      
    );
  }
}
