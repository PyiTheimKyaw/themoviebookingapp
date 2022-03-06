// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';

import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';

class MovieSeatItemView extends StatelessWidget {
  final MovieSeatVO? mMovieSeatVO;
  final Function(MovieSeatVO?) onTap;

  MovieSeatItemView({
    required this.mMovieSeatVO,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(mMovieSeatVO);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.5, vertical: 2),
        decoration: BoxDecoration(
            color: _getSeatColor(mMovieSeatVO),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                MARGIN_MEDIUM,
              ),
              topRight: Radius.circular(
                MARGIN_MEDIUM,
              ),
            )),
        child: Center(
          child: (mMovieSeatVO?.type == 'text')
              ? Text(
                  mMovieSeatVO?.symbol ?? "",
                  style: TextStyle(fontSize: 13),
                )
              : Text(
                  mMovieSeatVO?.seatName ?? "",
                  style: TextStyle(fontSize: 11),
                ),
        ),
      ),
    );
  }
}

Color _getSeatColor(MovieSeatVO? movieSeat) {

  if (movieSeat?.isSelected == true) {
    return PRIMARY_COLOR;
  }
  if(movieSeat?.type==SEAT_TYPE_TAKEN){
    return MOVIE_SEAT_TAKEN_COLOR;
  }
  if (movieSeat?.type ==SEAT_TYPE_AVAILABLE) {
    return MOVIE_SEAT_AVAILABLE_COLOR;
  }else {
    return Colors.white;
  }
}
