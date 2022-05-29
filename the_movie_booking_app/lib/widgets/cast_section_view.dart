import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/viewitems/actor_image_view.dart';

class CastSectionView extends StatelessWidget {
  final List<CreditVO>? castList;

  CastSectionView({required this.castList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CAST_TITLE_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_1X,
          ),
        ),
        Container(
          height: CAST_SECTION_HEIGHT,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: castList
                ?.map(
                  (cast) => (cast.profilePath?.isNotEmpty ?? false)
                  ? ActorsImageView(cast: cast)
                  : Container(),
            )
                .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

