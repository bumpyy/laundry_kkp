import 'package:flutter/material.dart';
import 'package:laundry_kkp/app/sign_in/sign_in_page.dart';
import 'package:laundry_kkp/screen/user_main.dart';
import 'package:laundry_kkp/services/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: Scaffold(
        body: Center(
          child: SharedPrefs().username != "" ? UserMain() : LoginScreen(),
        ),
      ),
    );
  }
}
