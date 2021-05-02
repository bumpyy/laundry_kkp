import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:laundry_kkp/screen/user_main.dart';
import 'package:laundry_kkp/services/db_helper.dart';
import 'package:laundry_kkp/services/shared_pref.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      var fentchData = await DatabaseHelper.instance
          .querySingleItem('users', data.name, ['*']);
      if (data.name.isEmpty) {
        return 'Email tidak boleh kosong';
      }
      if (data.password.isEmpty) {
        return 'Password tidak boleh kosong';
      }
      if (fentchData.isEmpty) {
        return 'data tidak ditemukan';
        // if (fentchData[0]['email'] != data.name) {
        //   return 'Email tidak ada';
        // }
        // if (fentchData[0]['pass'] != data.password) {
        //   return 'Password salah';
        // }
      }

      print(fentchData);

      SharedPrefs().username = data.name;
      return null;
    });
  }

  Future<String> _registerUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      if (data.name.isEmpty) {
        return 'Email tidak boleh kosong';
      }
      if (data.password.isEmpty) {
        return 'Password tidak boleh kosong';
      }

      await DatabaseHelper.instance
          .insert({'email': data.name, 'pass': data.password});

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
      // logo: 'assets/images/ecorp-lightblue.png',
      title: '&D LAUNDRY',
      hideForgotPasswordButton: true,
      onLogin: _authUser,
      // emailValidator: (email) => 'Email salah',
      // passwordValidator: (email) => 'Password salah',
      onSignup: _registerUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserMain(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
