import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:timeline/data/settings.dart';
import 'package:timeline/screens/home.dart';
import 'package:timeline/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

  Settings _settings = Settings();
  await _settings.getData();

  runApp(ChangeNotifierProvider(
    create: (_) => _settings,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);
    return MaterialApp(
      title: 'TimeLine',
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SettingsScreen.id: (context) => SettingsScreen()
      },
    );
  }
}
