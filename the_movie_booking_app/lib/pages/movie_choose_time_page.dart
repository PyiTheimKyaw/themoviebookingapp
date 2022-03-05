// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/movie_seats_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/widgets/floating_action_button_view.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class MovieChooseTimePage extends StatefulWidget {
  final int movieId;
  final String token;
  final String movieName;

  MovieChooseTimePage(
      {required this.movieId, required this.token, required this.movieName});

  @override
  State<MovieChooseTimePage> createState() => _MovieChooseTimePageState();
}

class _MovieChooseTimePageState extends State<MovieChooseTimePage> {
  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  List<CinemaDayTimeSlotVO>? cinemaInfo;
  TimeSlotVO? chooseDateVO;
  List<UserVO>? userData;
  String? dateData;
  String? userChooseTime;
  String? userChooseCinema;
  int? userChoosedayTimeslotId;
  int? cinemaId;

  @override
  void initState() {
    ///Get login userInfo From Database
    movieModel.getLoginUserIfoDatabase().listen((userInfo) {
      setState(() {
        userData = userInfo;
      });
      movieModel
          .getCinemaDayTimeslotFromDatabase(userData?.first.Authorization() ?? "",
          widget.movieId.toString(),dateData?.split("")[0] ?? DateTime.now().toString().split(" ")[0])
          .listen((value) {
        if(mounted) {
          setState(() {
            cinemaInfo = value?.cinemaList ?? [];
          });
        }
      }).onError((error) {
        print("Cinema dau time slot error default date at choose time page ${error.toString()}");
      });
      // movieModel
      //     .getCinemaDayTimeslot(
      //         userData?.first.Authorization() ?? "",
      //         widget.movieId.toString(),
      //         dateData?.split("")[0] ?? DateTime.now().toString().split(" ")[0])
      //     .then((value) {
      //   setState(() {
      //     cinemaInfo = value;
      //   });
      //
      //   print('Success');
      // }).catchError((error) {
      //   print("Get Movie Choose Time Error =====> ${error.toString()}");
      // });
    }).onError((error) {
      print("Userdata error at choose age ${error.toString()}");
    });



    super.initState();
  }

  getNewTimeslots(String date) {
    movieModel
        .getCinemaDayTimeslotFromDatabase(userData?.first.Authorization() ?? "",
        widget.movieId.toString(),dateData?.split("")[0] ?? DateTime.now().toString().split(" ")[0])
        .listen((value) {
      setState(() {
        cinemaInfo = value?.cinemaList ?? [];
      });
    }).onError((error) {
      print("Cinema dau time slot error choose date at choose time page ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
        width: MediaQuery.of(context).size.width * 0.93,
        height: FLOATING_ACTION_BUTTON_HEIGHT,
        child: FloatingActionButton.extended(
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            debugPrint('Api call success or fail ${cinemaInfo?[0].cinema}');
            debugPrint('Token at chooseTime Page ${widget.token}');
            debugPrint(
                'Token from database at chooseTime Page ${userData?[0].token} ');
            if (userChooseTime != "" &&
                userChoosedayTimeslotId != 0 &&
                userChooseCinema != "") {
              _navigateToNextScreen(
                  context,
                  dateData ?? DateTime.now().toString(),
                  userChooseTime ?? "",
                  userChooseCinema ?? "",
                  userChoosedayTimeslotId ?? 0,
                  cinemaId ?? 0,
                  widget.movieName,
                  widget.movieId,
                  userData?[0].token ?? "");
            }

            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget));
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieChooseDateView(
                selectedDate: (String? date) {
                  setState(() {
                    print("date data check ==========> ${date}");
                    dateData = date;
                    getNewTimeslots(date.toString().split(" ")[0] ?? "");
                  });
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.only(
                    top: MARGIN_MEDIUM_3,
                    left: MARGIN_MEDIUM_3,
                    right: MARGIN_MEDIUM_3),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cinemaInfo?.length ?? 0,
                    itemBuilder: (BuildContext context, int cinemaIndex) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cinemaInfo?[cinemaIndex].cinema ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: TEXT_REGULAR_2X,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: MARGIN_MEDIUM_3,
                            ),
                            GridView.builder(
                                itemCount:
                                    cinemaInfo?[cinemaIndex]
                                            .timeSlots
                                            ?.length ??
                                        0,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.5,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        cinemaInfo?.forEach((outer) {
                                          outer.timeSlots?.forEach((inner) {
                                            inner.isSelected = false;
                                          });
                                        });
                                        cinemaInfo?[cinemaIndex]
                                            .timeSlots?[index]
                                            .isSelected = true;
                                        userChooseTime =
                                            cinemaInfo?[cinemaIndex]
                                                .timeSlots?[index]
                                                .startTime;
                                        userChooseCinema =
                                            cinemaInfo?[cinemaIndex].cinema;
                                        userChoosedayTimeslotId =
                                            cinemaInfo?[cinemaIndex]
                                                .timeSlots?[index]
                                                .cinemaDayTimeSlotId;
                                        cinemaId =
                                            cinemaInfo?[cinemaIndex].cinemaId;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: MARGIN_MEDIUM_2,
                                          right: MARGIN_MEDIUM_2,
                                          top: MARGIN_MEDIUM),
                                      decoration: BoxDecoration(
                                        color: cinemaInfo?[cinemaIndex]
                                                    .timeSlots?[index]
                                                    .isSelected ==
                                                true
                                            ? PRIMARY_COLOR
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            MARGIN_MEDIUM),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: Center(
                                          child: Text(
                                        cinemaInfo?[cinemaIndex]
                                                .timeSlots?[index]
                                                .startTime ??
                                            "",
                                        style: TextStyle(
                                          color: cinemaInfo?[cinemaIndex]
                                                      .timeSlots?[index]
                                                      .isSelected ==
                                                  true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      );
                    }),
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

class MovieChooseDateView extends StatefulWidget {
  final Function(String?) selectedDate;

  MovieChooseDateView({required this.selectedDate});

  @override
  State<MovieChooseDateView> createState() => _MovieChooseDateViewState();
}

class _MovieChooseDateViewState extends State<MovieChooseDateView> {
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
                    setState(() {
                      widget.selectedDate(date.toString());
                    });
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
