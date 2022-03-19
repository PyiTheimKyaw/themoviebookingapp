// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/movie_choose_time_bloc.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/pages/movie_seats_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';

class MovieChooseTimePage extends StatelessWidget {
  final int movieId;

  // final String token;
  final String movieName;

  MovieChooseTimePage(
      {required this.movieId,
      // required this.token,
      required this.movieName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieChooseTimeBloc(movieId.toString()),
      child: Scaffold(
        floatingActionButton:
            Selector<MovieChooseTimeBloc, List<CinemaDayTimeSlotVO>?>(
          selector: (context, bloc) => bloc.mCinemaInfo,
          builder: (context, cinema, child) => Container(
            margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
            width: MediaQuery.of(context).size.width * 0.93,
            height: FLOATING_ACTION_BUTTON_HEIGHT,
            child: FloatingActionButton.extended(
              backgroundColor: PRIMARY_COLOR,
              onPressed: () {
                MovieChooseTimeBloc bloc =
                    Provider.of<MovieChooseTimeBloc>(context, listen: false);
                if (bloc.userChooseTime != "" &&
                    bloc.userChoosedayTimeslotId != 0 &&
                    bloc.userChooseCinema != "") {
                  _navigateToNextScreen(
                      context,
                      bloc.dateData ?? DateTime.now().toString(),
                      bloc.userChooseTime ?? "",
                      bloc.userChooseCinema ?? "",
                      bloc.userChoosedayTimeslotId ?? 0,
                      bloc.cinemaId ?? 0,
                      movieName,
                      movieId,
                      "");
                }
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: Text(
                'Next',
                style: TextStyle(
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: PRIMARY_COLOR,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: MARGIN_XLARGE,
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Selector<MovieChooseTimeBloc, String?>(
                selector: (context, bloc) => bloc.dateData,
                builder: (context, date, child) => MovieChooseDateView(
                  selectedDate: (String? date) {
                    MovieChooseTimeBloc bloc = Provider.of<MovieChooseTimeBloc>(
                        context,
                        listen: false);
                    bloc.getSelectedDate(movieId.toString(), date);
                    print("UserChoose dte ${bloc.dateData}");
                  },
                ),
              ),
              Selector<MovieChooseTimeBloc, List<CinemaDayTimeSlotVO>?>(
                selector: (context, bloc) => bloc.mCinemaInfo,
                builder: (context, cinemaInfo, child) =>
                    Selector<MovieChooseTimeBloc, String?>(
                  selector: (context, bloc) => bloc.userChooseTime,
                  builder: (context, chooseTime, child) =>
                      ChooseItemGridSectionView(
                    cinemaInfo: cinemaInfo,
                    onTap: (cIndex, index) {
                      MovieChooseTimeBloc bloc =
                          Provider.of<MovieChooseTimeBloc>(context,
                              listen: false);
                      bloc.onTapChooseTime(cIndex, index);
                      print("UserChoose time ${bloc.userChooseTime}");
                      print("UserChoose cinema ${bloc.userChooseCinema}");
                      print("UserChoose day ${bloc.userChoosedayTimeslotId}");
                      print("UserChoose dte ${bloc.dateData}");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_navigateToNextScreen(
    BuildContext context,
    String date,
    String chooseTime,
    String chooseCinema,
    int timeslotId,
    int cinemaId,
    String movieName,
    int movieId,
    String token) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => MovieSeatsPage(
              dateData: date,
              userChooseTime: chooseTime,
              userChooseCinema: chooseCinema,
              userChooseDayTimeslotId: timeslotId,
              cinemaId: cinemaId,
              movieName: movieName,
              movieId: movieId,
              token: token,
            )),
  );
}

class ChooseItemGridSectionView extends StatelessWidget {
  final List<CinemaDayTimeSlotVO>? cinemaInfo;
  final Function(int, int) onTap;

  ChooseItemGridSectionView({required this.cinemaInfo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.only(
          top: MARGIN_MEDIUM_3, left: MARGIN_MEDIUM_3, right: MARGIN_MEDIUM_3),
      // height: MediaQuery.of(context).size.height,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cinemaInfo?.length ?? 0,
            itemBuilder: (BuildContext context, int cinemaIndex) {
              return ChooseIemGridView(
                cIndex: cinemaIndex,
                cinemaInfo: cinemaInfo,
                onTap: (cIndex, index) => onTap(cIndex, index),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ChooseIemGridView extends StatelessWidget {
  final int cIndex;

  final List<CinemaDayTimeSlotVO>? cinemaInfo;
  final Function(int, int) onTap;

  ChooseIemGridView({
    required this.cIndex,
    required this.cinemaInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cinemaInfo?[cIndex].cinema ?? "",
            style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GridView.builder(
            itemCount: cinemaInfo?[cIndex].timeSlots?.length ?? 0,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTap(cIndex, index),
                child: Container(
                  margin: EdgeInsets.only(
                      left: MARGIN_MEDIUM_2,
                      right: MARGIN_MEDIUM_2,
                      top: MARGIN_MEDIUM),
                  decoration: BoxDecoration(
                    color:
                        cinemaInfo?[cIndex].timeSlots?[index].isSelected == true
                            ? PRIMARY_COLOR
                            : Colors.white,
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      cinemaInfo?[cIndex].timeSlots?[index].startTime ?? "",
                      style: TextStyle(
                        color:
                            cinemaInfo?[cIndex].timeSlots?[index].isSelected ==
                                    true
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MovieChooseDateView extends StatelessWidget {
  final Function(String?) selectedDate;

  MovieChooseDateView({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_TIME_DATE_LIST_HEIGHT,
      color: PRIMARY_COLOR,
      child: Container(
        height: MOVIE_TIME_DATE_LIST_HEIGHT,
        color: PRIMARY_COLOR,
        child: Stack(
          children: [
            Column(
              children: [
                DatePicker(
                  DateTime.now(),
                  daysCount: 14,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: PRIMARY_COLOR,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    selectedDate(date.toString());
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
