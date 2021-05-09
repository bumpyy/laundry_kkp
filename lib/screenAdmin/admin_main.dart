import 'package:flutter/material.dart';
import '../services/notification.dart';
import 'package:provider/provider.dart';
import '../pages/login_page.dart';
import '../widgets/sign_in_button.dart';

import '../services/shared_pref.dart';
import '../widgets/list_pesanan.dart';

class AdminMain extends StatefulWidget {
  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.green,
              width: double.infinity,
              height: 150.0,
            ),
            Text('ADMIN &D LAUNDRY'),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(),
                Text(SharedPrefs().username ?? 'error'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.green,
              width: 250,
              height: 250.0,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: SignInButton(
            //     onPressed: () => {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => PemesananAdmin(),
            //         ),
            //       )
            //     },
            //     color: Colors.green,
            //     text: "PESAN",
            //     textColor: Colors.black87,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SignInButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ListPesanan(),
                    ),
                  )
                },
                color: Colors.green,
                text: "DATA LAUNDRY",
                textColor: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: () => {
                SharedPrefs().username = '',
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                )
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
