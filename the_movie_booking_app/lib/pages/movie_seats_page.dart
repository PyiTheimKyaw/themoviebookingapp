// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/movie_seats_bloc.dart';
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

class MovieSeatsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          MovieSeatsBloc(userChooseDayTimeslotId, dateData.split(" ")[0]),
      child: Scaffold(
        floatingActionButton: Selector<MovieSeatsBloc, double>(
          selector: (context, bloc) => bloc.totalPrice,
          builder: (context, totalPrice, child) => Container(
            margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
            width: MediaQuery.of(context).size.width * 0.93,
            height: FLOATING_ACTION_BUTTON_HEIGHT,
            child: FloatingActionButton.extended(
              backgroundColor: PRIMARY_COLOR,
              onPressed: () {
                MovieSeatsBloc bloc =
                    Provider.of<MovieSeatsBloc>(context, listen: false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SnackListPage(
                            price: bloc.totalPrice,
                            cinemaId: cinemaId,
                            userChooseCinema: userChooseCinema,
                            userChooseDayTimeslotId: userChooseDayTimeslotId,
                            userChooseTime: userChooseTime,
                            dateData: dateData,
                            movieName: movieName,
                            movieId: movieId,
                            token: token,
                            seatNo: bloc.pickSeat.join(','),
                          )),
                );
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: Text(
                'Buy Ticket for \$${totalPrice}',
                style: TextStyle(
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
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
                  mName: movieName,
                  cName: userChooseCinema,
                  dateAndTime: '${dateData.split(" ")[0]},${userChooseTime}',
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                // Selector<MovieSeatsBloc, List<MovieSeatVO>?>(
                //   selector: (context, bloc) => bloc.mMovieSeats,
                //   builder: (context, movieSeats, child) =>
                //       Selector<MovieSeatsBloc, int>(
                //     selector: (context, bloc) => bloc.tickets,
                //     builder: (context, tickets, child) => MovieSeatsSectionView(
                //       movieSeats: movieSeats,
                //       onTapSeats: (seat) {
                //         MovieSeatsBloc bloc =
                //             Provider.of<MovieSeatsBloc>(context, listen: false);
                //         bloc.onChooseSeat(seat);
                //       },
                //     ),
                //   ),
                // ),
                Selector<MovieSeatsBloc, List<MovieSeatVO>?>(
                  selector: (context, bloc) => bloc.mMovieSeats,
                  shouldRebuild: (previous,next) => previous != next,
                  builder: (context, movieSeats, child) =>
                      MovieSeatsSectionView(
                        movieSeats: movieSeats,
                        onTapSeats: (seat) {
                          MovieSeatsBloc bloc =
                          Provider.of<MovieSeatsBloc>(context, listen: false);
                          bloc.onChooseSeat(seat);
                        },
                      ),
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
                Selector<MovieSeatsBloc, int>(
                  selector: (context, bloc) => bloc.tickets,
                  builder: (context, tickets, child) =>
                      Selector<MovieSeatsBloc, List<String>>(
                    selector: (context, bloc) => bloc.pickSeat,
                    builder: (context, pickSeat, child) =>
                        NumberOfTicketsAndSeatsSectionView(
                      tickets: tickets.toString(),
                      row: pickSeat.join(','),
                    ),
                  ),
                ),
                SizedBox(
                  height: MARGIN_XXLARGE + MARGIN_XXLARGE,
                ),
              ],
            ),
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
