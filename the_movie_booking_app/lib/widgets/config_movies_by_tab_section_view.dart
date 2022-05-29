import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/viewitems/movie_view.dart';
import 'package:the_movie_booking_app/widgets/config_now_showing_and_coming_soon_movies_section_view.dart';
import 'package:the_movie_booking_app/widgets/movie_view_title_text_view.dart';

class ConfigMoviesByTabSectionView extends StatefulWidget {
  const ConfigMoviesByTabSectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigMoviesByTabSectionView> createState() =>
      _ConfigMoviesByTabSectionViewState();
}

class _ConfigMoviesByTabSectionViewState
    extends State<ConfigMoviesByTabSectionView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: tabController,
          labelColor: PRIMARY_COLOR,
          unselectedLabelColor: Colors.black38,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: PRIMARY_COLOR,
          tabs: [
            Tab(
              text: "Now Showing",
            ),
            Tab(
              text: "Coming Soon",
            ),
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM_4,),
        Expanded(
          child: TabBarView(
              controller: tabController,
              children: [
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.mNowPlayingMovies,
                  builder: (context, nowPlayingMovies, child) =>
                      NowShowingAndComingSoonMovieByGridSectionView(
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
                      NowShowingAndComingSoonMovieByGridSectionView(
                        title: HOME_PAGE_COMING_SOON_TEXT,
                        onTapMovie: (movieId) {
                          navigateToMovieDetailsScreen(context, movieId);
                        },
                        movie: comingSoonMovies,
                      ),
                ),
          ])
        ),
      ],
    );
  }
}
class NowShowingAndComingSoonMovieByGridSectionView extends StatelessWidget {
  final String title;
  final Function(int?) onTapMovie;
  final List<MovieVO>? movie;

  NowShowingAndComingSoonMovieByGridSectionView(
      {required this.title, required this.onTapMovie, required this.movie});

  @override
  Widget build(BuildContext context) {
    return VerticalMovieListView(
      onTapMovie: (movieId) => this.onTapMovie(movieId),
      movieList: movie,
    );
  }
}
class VerticalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  VerticalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? GridView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.vertical,
        itemCount: movieList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onTapMovie(movieList?[index].id),
            child: MovieView(
              movie: movieList?[index],
            ),
          );
        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 0.43),
      )
          : Center(
        child: Container(),
      ),
    );
  }
}
