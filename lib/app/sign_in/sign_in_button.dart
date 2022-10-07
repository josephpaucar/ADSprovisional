import 'package:aves_de_san_martin/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    super.key,
    required String text,
    required Color color,
    required Color textColor,
    VoidCallback? onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 15.0, fontFamily: 'Poppins'),
          ),
          color: color,
          onPressed: onPressed,
        );
}
