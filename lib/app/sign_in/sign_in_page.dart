import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:laundry_kkp/screen/user_main.dart';
import 'package:laundry_kkp/services/shared_pref.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Email tidak ada';
      }
      if (users[data.name] != data.password) {
        return 'Password salah';
      }
      SharedPrefs().username = data.name;
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ECORP',
      hideSignUpButton: true,
      logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserMain(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
