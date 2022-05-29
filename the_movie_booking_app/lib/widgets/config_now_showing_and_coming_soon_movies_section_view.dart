import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/viewitems/movie_view.dart';
import 'package:the_movie_booking_app/widgets/movie_view_title_text_view.dart';

class ConfigNowShowingAndComingSoonMoviesSectionView extends StatelessWidget {
  const ConfigNowShowingAndComingSoonMoviesSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<HomeBloc, List<MovieVO>?>(
            selector: (context, bloc) => bloc.mNowPlayingMovies,
            builder: (context, nowPlayingMovies, child) =>
                NowShowingAndComingSoonMovieSectionView(
                  title: HOME_PAGE_NOW_SHOWING_TEXT,
                  onTapMovie: (movieId) {
                    navigateToMovieDetailsScreen(context, movieId);
                  },
                  movie: nowPlayingMovies,
                ),
          ),
          Selector<HomeBloc, List<MovieVO>?>(
            selector: (context, bloc) => bloc.mComingSoonMovies,
            builder: (context, comingSoonMovies, child) =>
                NowShowingAndComingSoonMovieSectionView(
                  title: HOME_PAGE_COMING_SOON_TEXT,
                  onTapMovie: (movieId) {
                    navigateToMovieDetailsScreen(context, movieId);
                  },
                  movie: comingSoonMovies,
                ),
          ),
        ],
      ),
    );
  }
}
class NowShowingAndComingSoonMovieSectionView extends StatelessWidget {
  final String title;
  final Function(int?) onTapMovie;
  final List<MovieVO>? movie;

  NowShowingAndComingSoonMovieSectionView(
      {required this.title, required this.onTapMovie, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: MovieViewTitleTextView(title),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) => this.onTapMovie(movieId),
          movieList: movie,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
        // shrinkWrap: true,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2,bottom: MediaQuery.of(context).viewInsets.bottom,),
        scrollDirection: Axis.horizontal,
        itemCount: movieList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onTapMovie(movieList?[index].id),
            child: MovieView(
              movie: movieList?[index],
            ),
          );
        },
      )
          : Center(
        child: Container(),
      ),
    );
  }
}
void navigateToMovieDetailsScreen(BuildContext context, int? movieId) {
  if (movieId != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(
          movieId: movieId,
          // token: userInfo?[0].token ?? "",
        ),
      ),
    );
  }
}