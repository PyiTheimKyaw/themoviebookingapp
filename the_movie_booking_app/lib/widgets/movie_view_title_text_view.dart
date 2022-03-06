import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';

class MovieViewTitleTextView extends StatelessWidget {
  final String title;
  MovieViewTitleTextView(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: TEXT_REGULAR_1X,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
