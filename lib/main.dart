import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:timeline/data/settings.dart';
import 'package:timeline/screens/draggable_screen.dart';
import 'package:timeline/screens/home.dart';
import 'package:timeline/screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(ChangeNotifierProvider(
    create: (_) => Settings(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _future;

  @override
  void initState() {
    _future = context.read<Settings>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);
    return FutureBuilder(
      future: _future,
      builder: (_, __) => MaterialApp(
        title: 'TimeLine',
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          DraggableScreen.id: (_) => DraggableScreen()
        },
      ),
    );
  }
}
