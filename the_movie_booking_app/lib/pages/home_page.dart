// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/login_and_sign_in_page.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/viewitems/movie_view.dart';
import 'package:the_movie_booking_app/widgets/movie_view_title_text_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../data/vos/snack_list_vo.dart';

import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  Map<String, dynamic>? userData;
  String googleId;

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
  MovieModel mMovieModel = MovieModelImpl();
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? comingSoonMovies;
  List<UserVO>? userInfo;
  List<SnackListVO>? snackList;

  AccessToken? _accessToken;

  @override
  void initState() {
    // ///Now Playing Movies
    // mMovieModel.getNowPlayingMovies().then((movieList) {
    //   setState(() {
    //     nowPlayingMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint('Error ======> ${error.toString()}');
    // });

    ///Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      if(mounted) {
        setState(() {
          nowPlayingMovies = movieList;
        });
      }
    }).onError((error) {
      debugPrint('Error ======> ${error.toString()}');
    });

    // ///Coming Soon Movies
    // mMovieModel.getComingSoonMovies().then((movieList) {
    //   setState(() {
    //     comingSoonMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint('Error ======> ${error.toString()}');
    // });

    ///Coming Soon Movies Database
    mMovieModel.getComingSoonMoviesFromDatabase().listen((movieList) {
      if(mounted) {
        setState(() {
          comingSoonMovies = movieList;
        });
      }
    }).onError((error) {
      debugPrint('Error ======> ${error.toString()}');
    });

    ///User from database
    mMovieModel.getLoginUserIfoDatabase().listen((user) {
      if(mounted) {
        setState(() {
          userInfo = user;
        });
      }
      // mMovieModel
      //     .getSnackList(userInfo?[0].Authorization() ?? "")
      //     .then((value) {
      //   snackLis = value;
      // });
      // mMovieModel.getSnackListFromDatabase(userInfo?.first.Authorization() ?? "").listen((snack) {
      //   setState(() {
      //     snackList=snack;
      //   });
      // }).onError((error){
      //   print("Snack list error at home page ${error.toString()}");
      // });
    }).onError((error) {
      debugPrint('Error ======> ${error.toString()}');
    });

    super.initState();
  }

  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    widget.userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                DrawerHeaderSectionView(
                  user: userInfo?.first,
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                MenuItemSectionView(menuItem: menuItem),
                Spacer(),
                LogOutButtonSectionView(
                  onTapButton: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Confirm"),
                        content: Text("Are you sure to log out"),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              if (widget.userData != null) {
                                print('User data is not null');
                                _logOut();
                                mMovieModel.logoutUser(
                                    userInfo?.first.Authorization() ?? "");
                                debugPrint(
                                    'token in tap ${userInfo?[0].token}');
                                mMovieModel.logoutUserFromDatabase();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginAndSignInPage()),
                                    (Route<dynamic> route) => false);
                              }
                              if (widget.googleId != null) {
                                GoogleSignIn _googleSignIn = GoogleSignIn(
                                  scopes: [
                                    'email',
                                    'https://www.googleapis.com/auth/contacts.readonly',
                                  ],
                                );
                                _googleSignIn.signOut().then((value) {
                                  print('Google logout successfully');
                                }).catchError((error) {
                                  print(
                                      'Google logout failed ${error.toString()}');
                                });
                              }
                              mMovieModel.logoutUser(
                                  userInfo?.first.Authorization() ?? "");
                              debugPrint('token in tap ${userInfo?[0].token}');
                              mMovieModel.logoutUserFromDatabase();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginAndSignInPage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text("Okay"),
                          ),
                        ],
                      ),
                    );
                  },
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
              ProfileImageAndNameSectionView(
                name: userInfo?[0],
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              NowShowingAndComingSoonMovieSectionView(
                title: HOME_PAGE_NOW_SHOWING_TEXT,
                onTapMovie: (movieId) {
                  _navigateToMovieDetailsScreen(context, movieId);
                },
                movie: nowPlayingMovies,
              ),
              NowShowingAndComingSoonMovieSectionView(
                title: HOME_PAGE_COMING_SOON_TEXT,
                onTapMovie: (movieId) {
                  _navigateToMovieDetailsScreen(context, movieId);
                },
                movie: comingSoonMovies,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsPage(
            movieId: movieId,
            token: userInfo?[0].token ?? "",
          ),
        ),
      );
    }
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
  final UserVO? user;

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
                user?.name ?? "",
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
                      user?.email ?? "",
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

  final UserVO? name;

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
          TitleText(
            'Hi ${name?.name ?? ""}!',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
