import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';

class ActorsImageView extends StatelessWidget {
  final CreditVO? cast;

  ActorsImageView({required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: PROFILE_IMAGE_SIZE,
      height: PROFILE_IMAGE_SIZE,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage('$IMAGE_BASE_URL${cast?.profilePath ?? ""}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}