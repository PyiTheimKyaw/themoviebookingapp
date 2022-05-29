// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/movie_details_bloc.dart';
import 'package:the_movie_booking_app/config/config_values.dart';
import 'package:the_movie_booking_app/config/environment_config.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/pages/movie_choose_time_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/widgets/blur_title_text_view.dart';
import 'package:the_movie_booking_app/widgets/floating_action_button_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  // String token;

  MovieDetailsPage({
    required this.movieId,
    // required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieDetailsBloc>.value(
      value: MovieDetailsBloc(movieId),
      child: Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
          width: MediaQuery.of(context).size.width * 0.93,
          height: FLOATING_ACTION_BUTTON_HEIGHT,
          child: Selector<MovieDetailsBloc, MovieVO?>(
            selector: (_, bloc) => bloc.mMovieDetails,
            builder: (_, movieDetails, child) => FloatingActionButton.extended(
              backgroundColor: PRIMARY_COLOR,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieChooseTimePage(
                            movieId: movieId,
                            // token: widget.token,
                            movieName: movieDetails?.title ?? "",
                          )),
                );
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget));
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: Text(
                'Get Your Ticket',
                style: TextStyle(
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        body: Selector<MovieDetailsBloc, MovieVO?>(
          selector: (context, bloc) => bloc.mMovieDetails,
          builder: (context, movieDetails, child) => CustomScrollView(
            slivers: [
              MovieDetailsSliverAppBarView(
                movie: movieDetails,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      color: Colors.white,
                      // height:double.infinity,
                      padding: EdgeInsets.only(
                        left: MARGIN_MEDIUM_2,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MovieTitleVieww(
                              title: movieDetails?.title ?? "",
                            ),
                            SizedBox(
                              height: MARGIN_MEDIUM_2,
                            ),
                            DurationAndRatingView(
                              rating: movieDetails?.voteAverage.toString() ?? "",
                            ),
                            SizedBox(
                              height: MARGIN_MEDIUM_2,
                            ),
                            GenreSectionView(
                                genreList:
                                    movieDetails?.getGenreListAsStringList() ??
                                        []),
                            SizedBox(
                              height: MARGIN_MEDIUM,
                            ),
                            PlotSummarySectionView(
                              plot: movieDetails?.overView ?? "",
                            ),
                            SizedBox(
                              height: MARGIN_LARGE,
                            ),
                            CAST_VIEW[EnvironmentConfig.CONFIG_CAST_VIEW],
                            SizedBox(
                              height: 600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieTitleVieww extends StatelessWidget {
  String title;

  MovieTitleVieww({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: TEXT_REGULAR_2X,
      ),
    );
  }
}



class PlotSummarySectionView extends StatelessWidget {
  String plot;

  PlotSummarySectionView({required this.plot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PLOT_SUMMARY_TEXT,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TEXT_REGULAR_1X,
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Flexible(
          flex: 0,
          fit: FlexFit.tight,
          child: Text(
            plot,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR,
              color: Color.fromRGBO(114, 114, 114, 1.0),
            ),
          ),
        ),
      ],
    );
  }
}

class GenreSectionView extends StatelessWidget {
  GenreSectionView({
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...genreList.map((genre) => GenreChipView(genre)).toList(),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreList;

  GenreChipView(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: CHIP_CONTAINER_HEIGHT,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          child: Chip(
            backgroundColor: Colors.white,
            label: Text(genreList),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class DurationAndRatingView extends StatelessWidget {
  final String rating;

  DurationAndRatingView({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlurTitleText('1hr 3min', DURATION_AND_RATING_TEXT_COLOR),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        RatingBarView(),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        BlurTitleText('IMDb $rating', DURATION_AND_RATING_TEXT_COLOR),
      ],
    );
  }
}

class RatingBarView extends StatelessWidget {
  const RatingBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: RATING_BAR_ITEM_SIZE,
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (BuildContext context, int index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final MovieVO? movie;

  MovieDetailsSliverAppBarView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      expandedHeight: MOVIE_DETAILS_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: (movie?.posterPath?.isNotEmpty ?? false)
                      ? MovieDetailsImageView(
                          imageUrl: movie?.posterPath ?? "",
                        )
                      : Container(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: PlayButtonView(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MARGIN_LARGE,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(MARGIN_LARGE),
                  topLeft: Radius.circular(MARGIN_LARGE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_circle_outline,
      size: PLAY_BUTTON_SIZE,
      color: Colors.white,
    );
  }
}

class MovieDetailsImageView extends StatelessWidget {
  String imageUrl;

  MovieDetailsImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$imageUrl',
      fit: BoxFit.cover,
    );
  }
}
