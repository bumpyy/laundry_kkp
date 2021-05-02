import 'package:flutter/material.dart';
import '../../common_widgets/custom_elevated_widget.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    @required String text,
    double radius: 4.0,
    Color color: Colors.white,
    Color textColor: Colors.white,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
            ),
          ),
          color: color,
          onPressed: onPressed,
          borderRadius: radius,
        );
}
