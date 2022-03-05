import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color textColor;
  TitleText(this.text,{this.textColor= Colors.white});

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: TEXT_REGULAR_2X,
      ),
    );
  }
}
