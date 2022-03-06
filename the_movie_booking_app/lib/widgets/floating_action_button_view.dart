// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';

class FloatingActionButtonView extends StatefulWidget {
  final String text;
  final Widget widget;

  FloatingActionButtonView(this.text, this.widget);

  @override
  State<FloatingActionButtonView> createState() =>
      _FloatingActionButtonViewState();
}

class _FloatingActionButtonViewState extends State<FloatingActionButtonView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
      width: MediaQuery.of(context).size.width * 0.93,
      height: FLOATING_ACTION_BUTTON_HEIGHT,
      child: FloatingActionButton.extended(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.widget),
          );
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget));
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        label: Text(
          widget.text,
          style: TextStyle(
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
