import 'package:flutter/material.dart';
import 'package:laundry_kkp/app/sign_in/sign_in_button.dart';
import 'package:laundry_kkp/app/sign_in/sign_in_page.dart';
import 'package:laundry_kkp/screen/pemesanan.dart';
import 'package:laundry_kkp/services/shared_pref.dart';
import 'package:laundry_kkp/widgets/list_pesanan.dart';

class UserMain extends StatelessWidget {
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
            Text('&D LAUNDRY'),
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
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SignInButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Pemesanan(),
                    ),
                  )
                },
                color: Colors.green,
                text: "PESAN",
                textColor: Colors.black87,
              ),
            ),
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
                text: "CEK STATUS PENGERJAAN",
                textColor: Colors.black87,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => {
                SharedPrefs().username = '',
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ))
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
