import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';

class BlurTitleText extends StatelessWidget {
  final String text;
  final Color textColor;
  BlurTitleText(this.text,this.textColor);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: TEXT_REGULAR,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
