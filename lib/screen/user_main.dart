import 'package:flutter/material.dart';
import 'package:laundry_kkp/app/sign_in/sign_in_button.dart';
import 'package:laundry_kkp/screen/pemesanan.dart';

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
                Text('Dimas Prayoga'),
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
                      builder: (_) => null,
                    ),
                  )
                },
                color: Colors.green,
                text: "CEK STATUS PENGERJAAN",
                textColor: Colors.black87,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}