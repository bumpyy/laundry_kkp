import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'screen/user_main.dart';
import 'services/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData().copyWith(
        primaryColor: Colors.green,
        accentColor: Colors.green,
      ),
      home: Scaffold(
        body: Center(
          child: SharedPrefs().username != "" ? UserMain() : LoginPage(),
        ),
      ),
    );
  }
}
