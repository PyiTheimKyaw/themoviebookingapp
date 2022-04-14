// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/login_and_sign_in_page.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/viewitems/movie_view.dart';
import 'package:the_movie_booking_app/widgets/movie_view_title_text_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../data/vos/snack_list_vo.dart';

class HomePage extends StatefulWidget {
  Map<String, dynamic>? userData;
  String? googleId;

  HomePage({required this.userData, required this.googleId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> menuItem = [
    "Promotion Code",
    "Select a Language",
    "Terms of Services",
    "Help",
    "Rate us"
  ];
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   HomeBloc bloc=Provider.of(context,listen: false);
  //   bloc.isDispose=true;
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Drawer(
            backgroundColor: PRIMARY_COLOR,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Column(
                children: [
                  SizedBox(
                    height: MARGIN_XXLARGE,
                  ),
                  Selector<HomeBloc, List<UserVO>?>(
                    selector: (context, bloc) => bloc.mUserInfo,
                    builder: (context, user, child) => DrawerHeaderSectionView(
                      user: user,
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  MenuItemSectionView(menuItem: menuItem),
                  Spacer(),
                  Builder(
                    builder: (context) => LogOutButtonSectionView(
                      onTapButton: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Confirm"),
                            content: Text("Are you sure to log out"),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  HomeBloc bloc =
                                      Provider.of(context, listen: false);
                                  if (widget.userData != null) {
                                    print('User data is not null');
                                    bloc.logOutFacebook().then((value) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginAndSignInPage()),
                                      );
                                    });
                                  }
                                  if (widget.googleId != null) {
                                    bloc
                                        .onTapGoogleLogOut()
                                        .then((googleSignIn) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginAndSignInPage()),
                                      );
                                    });
                                  }
                                  bloc.onTapLogoutUser().then((value) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginAndSignInPage()),
                                    );
                                  });
                                },
                                child: Text("Okay"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_XLARGE,
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          // leading: Icon(
          //   Icons.menu,
          //   color: Colors.black,
          //   size: MARGIN_LARGE,
          // ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: MARGIN_LARGE,
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Selector<HomeBloc, List<UserVO>?>(
                  selector: (context, bloc) => bloc.mUserInfo,
                  builder: (context, user, child) =>
                      ProfileImageAndNameSectionView(
                    name: user,
                  ),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.mNowPlayingMovies,
                  builder: (context, nowPlayingMovies, child) =>
                      NowShowingAndComingSoonMovieSectionView(
                    title: HOME_PAGE_NOW_SHOWING_TEXT,
                    onTapMovie: (movieId) {
                      _navigateToMovieDetailsScreen(context, movieId);
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
                      _navigateToMovieDetailsScreen(context, movieId);
                    },
                    movie: comingSoonMovies,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _navigateToMovieDetailsScreen(BuildContext context, int? movieId) {
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

class LogOutButtonSectionView extends StatelessWidget {
  final Function onTapButton;

  LogOutButtonSectionView({required this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapButton();
      },
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.white,
          size: MARGIN_LARGE,
        ),
        title: Text(
          'Log out',
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ),
    );
  }
}

class MenuItemSectionView extends StatelessWidget {
  const MenuItemSectionView({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  final List<String> menuItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menuItem.map(
        (menu) {
          return Container(
            margin: EdgeInsets.only(top: MARGIN_MEDIUM_2),
            child: ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.white,
                size: MARGIN_LARGE,
              ),
              title: Text(
                menu,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

class DrawerHeaderSectionView extends StatelessWidget {
  final List<UserVO>? user;

  DrawerHeaderSectionView({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: PROFILE_IMAGE_SIZE,
          height: PROFILE_IMAGE_SIZE,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/chris.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?[0].name ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      user?[0].email ?? "",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MARGIN_LARGE,
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
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

class ProfileImageAndNameSectionView extends StatelessWidget {
  ProfileImageAndNameSectionView({required this.name});

  final List<UserVO>? name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
      child: Row(
        children: [
          Container(
            width: PROFILE_IMAGE_SIZE,
            height: PROFILE_IMAGE_SIZE,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/chris.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Flexible(
            child: TitleText(
              'Hi ${name?[0].name ?? ""}!',
              textColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
