// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/widgets/blur_title_text_view.dart';

class MovieView extends StatelessWidget {
  final MovieVO? movie;
  //final Function onTapMovie;
  MovieView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_ITEM_WIDTH,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   image: DecorationImage(
      //     image: AssetImage(
      //       'images/pikachu.jpg',
      //     ),
      //     fit: BoxFit.cover,
      //
      //   ),
      // ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: MovieItemImageView(

              movie: movie,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Text(
            movie?.title ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: TEXT_SMALL_1X,
            ),
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Text(
            'Myystery/Adventure - 1hr 45min',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TEXT_SMALL,
                color: Color.fromRGBO(194, 201, 217, 1.0)),
          ),
        ],
      ),
    );
  }
}

class MovieItemImageView extends StatelessWidget {

  final MovieVO? movie;
  MovieItemImageView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL${movie?.posterPath ?? ""}',
      fit: BoxFit.cover,
    );
  }
}
