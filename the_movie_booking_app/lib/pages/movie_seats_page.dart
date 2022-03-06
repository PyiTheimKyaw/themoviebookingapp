// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/dummy/dummy_data.dart';
import 'package:the_movie_booking_app/pages/snack_list_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/rescources/strings.dart';
import 'package:the_movie_booking_app/viewitems/movie_seat_item_view.dart';
import 'package:the_movie_booking_app/widgets/floating_action_button_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';

class MovieSeatsPage extends StatefulWidget {
  final String dateData;
  final String userChooseTime;
  final String userChooseCinema;
  final int userChooseDayTimeslotId;
  final int cinemaId;
  final String movieName;
  final int movieId;
  final String token;

  MovieSeatsPage(
      {required this.dateData,
      required this.userChooseTime,
      required this.userChooseCinema,
      required this.userChooseDayTimeslotId,
      required this.cinemaId,
      required this.movieName,
      required this.movieId,
      required this.token});

  @override
  State<MovieSeatsPage> createState() => _MovieSeatsPageState();
}

class _MovieSeatsPageState extends State<MovieSeatsPage> {
  List<MovieSeatVO>? movieSeats;
  List<UserVO>? userInfo;
  MovieModel mMovieModel = MovieModelImpl();
  int? countRow;
  List<String> pickSeat = [];
  String? totalSeat;
  String? totalRow;
  double totalPrice = 0;
  int tickets = 0;

  @override
  void initState() {
    ///User From database
    mMovieModel.getLoginUserIfoDatabase().listen((user) {
      setState(() {
        userInfo = user;
      });


    }).onError((error){
      print("Userdata error at seat page ${error.toString()}");
    });
    ///Seat
    mMovieModel
        .getCinemaSeatingPlan(userInfo?[0].Authorization() ?? "",
        widget.userChooseDayTimeslotId, widget.dateData)
        .then((seats) {
      setState(() {
        movieSeats = seats;
      });
      print('Success seat choice');
    });
    ///Seat from database
    mMovieModel.getMovieSeatsFromDatabase().then((value) {
      setState(() {
        movieSeats = value;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    // Future.delayed(Duration(seconds: 5), () {
    //   print('Token at seat page : ${userInfo?[0].token ?? ""}');
    //   print('date at seat page : ${widget.dateData}');
    //   print('id at seat page : ${widget.userChooseDayTimeslotId}');
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButtonView(
          'Buy Ticket for \$${totalPrice}',
          SnackListPage(
            price: totalPrice,
            cinemaId: widget.cinemaId,
            userChooseCinema: widget.userChooseCinema,
            userChooseDayTimeslotId: widget.userChooseDayTimeslotId,
            userChooseTime: widget.userChooseTime,
            dateData: widget.dateData,
            movieName: widget.movieName,
            movieId: widget.movieId,
            token: widget.token,
            seatNo: pickSeat.join(','),
          )),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: MARGIN_LARGE,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieNameTimeAndCinemaSectionView(
                mName: widget.movieName,
                cName: widget.userChooseCinema,
                dateAndTime:
                    '${widget.dateData.split(" ")[0]},${widget.userChooseTime}',
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              MovieSeatsSectionView(
                movieSeats: movieSeats,
                onTapSeats: (seat) {
                  if (seat?.type == SEAT_TYPE_AVAILABLE) {
                    List<MovieSeatVO>? tempSeats = movieSeats;
                    tempSeats?.forEach((element) {
                      if (element.id == seat?.id &&
                          element.symbol == seat?.symbol) {
                        element.isSelected =
                            (seat?.isSelected == false) ? true : false;
                      }
                    });
                    if (seat?.isSelected == true) {
                      pickSeat.add(seat?.seatName ?? "");
                      totalPrice += seat?.price ?? 0;
                      tickets++;
                    } else {
                      pickSeat.remove(seat?.seatName ?? "");
                      totalPrice -= seat?.price ?? 0;
                      tickets--;
                    }
                    setState(() {
                      movieSeats = tempSeats;
                    });
                  }
                },
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              MovieSeatsGlossarySectionView(),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              DottedLineSectionView(),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              NumberOfTicketsAndSeatsSectionView(
                tickets: tickets.toString(),
                row: pickSeat.join(','),
              ),
              SizedBox(
                height: MARGIN_XXLARGE + MARGIN_XXLARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberOfTicketsAndSeatsSectionView extends StatelessWidget {
  String row;
  String tickets;

  NumberOfTicketsAndSeatsSectionView(
      {required this.row, required this.tickets});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          NumberOfTicketsAndSeatsView(
            mTitle: LABEL_TICKET,
            mInfo: tickets,
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          NumberOfTicketsAndSeatsView(mTitle: LABEL_SEAT, mInfo: row),
        ],
      ),
    );
  }
}

class NumberOfTicketsAndSeatsView extends StatelessWidget {
  final String mTitle;
  final String mInfo;

  NumberOfTicketsAndSeatsView({required this.mTitle, required this.mInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 0,
          child: Text(
            mTitle,
            style: TextStyle(
              color: MOVIE_CINEMA_COLOR,
              fontSize: TEXT_REGULAR,
            ),
          ),
        ),
        Spacer(),
        Flexible(
          flex: 1,
          child: Text(
            mInfo,
            style: TextStyle(
              color: MOVIE_CINEMA_COLOR,
              fontSize: TEXT_REGULAR,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieSeatsGlossarySectionView extends StatelessWidget {
  const MovieSeatsGlossarySectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: MovieSeatGlossaryView(
                LABEL_AVAILABLE, MOVIE_SEAT_AVAILABLE_COLOR),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlossaryView(LABEL_TAKEN, MOVIE_SEAT_TAKEN_COLOR),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlossaryView(LABEL_YOUR_SELECTION, PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }
}

class DottedLineSectionView extends StatelessWidget {
  const DottedLineSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0,
        dashLength: MARGIN_MEDIUM,
        dashColor: Color.fromRGBO(196, 203, 220, 0.5),
        // dashGradient: [Colors.red, Colors.blue],
        dashGapLength: MARGIN_MEDIUM,
        dashGapColor: Colors.transparent,
        // dashGapGradient: [Colors.red, Colors.blue],
        dashGapRadius: 0.0,
      ),
    );
  }
}

class MovieSeatGlossaryView extends StatelessWidget {
  final String text;
  final Color color;

  MovieSeatGlossaryView(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: MARGIN_MEDIUM_3,
          width: MARGIN_MEDIUM_3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Text(
          text,
          style: TextStyle(
            color: Color.fromRGBO(144, 145, 157, 1.0),
          ),
        ),
      ],
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  final List<MovieSeatVO>? movieSeats;

  // final  int? countRow;
  final Function(MovieSeatVO?) onTapSeats;

  MovieSeatsSectionView({required this.movieSeats, required this.onTapSeats});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieSeats?.length ?? 0,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 14,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return MovieSeatItemView(
          mMovieSeatVO: movieSeats?[index],
          onTap: onTapSeats,
        );
      },
    );
  }
}

class MovieNameTimeAndCinemaSectionView extends StatelessWidget {
  String mName;
  String cName;
  String dateAndTime;

  MovieNameTimeAndCinemaSectionView(
      {required this.mName, required this.cName, required this.dateAndTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(
          mName,
          textColor: Colors.black,
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          cName,
          style: TextStyle(
            color: MOVIE_CINEMA_COLOR,
            fontSize: TEXT_REGULAR,
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          dateAndTime,
          style: TextStyle(
            color: MOVIE_TIME_COLOR,
            fontSize: TEXT_REGULAR,
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
      ],
    );
  }
}
