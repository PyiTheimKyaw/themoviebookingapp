// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/voucher_bloc.dart';
import 'package:the_movie_booking_app/data/models/movie_model.dart';
import 'package:the_movie_booking_app/data/models/movie_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/payment_card_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/rescources/colors.dart';
import 'package:the_movie_booking_app/rescources/dimens.dart';
import 'package:the_movie_booking_app/widgets/blur_title_text_view.dart';
import 'package:the_movie_booking_app/widgets/title_text_view.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dotted_border/dotted_border.dart';

// import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class VoucherPage extends StatelessWidget {
  final double price;
  String dateData;
  final String userChooseTime;
  final String userChooseCinema;
  final int userChooseDayTimeslotId;
  final int cinemaId;
  final String movieName;
  final int movieId;
  final String token;
  final int cardId;
  final CheckoutVO? checkoutVO;

  VoucherPage(
      {required this.price,
      required this.dateData,
      required this.userChooseTime,
      required this.userChooseCinema,
      required this.userChooseDayTimeslotId,
      required this.cinemaId,
      required this.movieName,
      required this.movieId,
      required this.token,
      required this.cardId,
      required this.checkoutVO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) =>  VoucherBloc(movieId),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => HomePage(
                    userData: null,
                    googleId: "",
                  )),
            ),
            child: Center(
              child: Image(
                image: AssetImage('images/cancel.png'),
                fit: BoxFit.cover,
                height: VOUCHER_LEADING_SIZE,
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VoucherHeadingTitleSectionView(),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, //color of shadow
                      spreadRadius: 5, //spread radius
                      blurRadius: 20, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    ),
                    //you can set more BoxShadow() here
                  ],
                ),
                child: Column(
                  children: [
                    Selector<VoucherBloc, MovieVO?>(
                      selector: (context, bloc) => bloc.mMovieDetails,
                      builder: (context, movie, child) =>
                          MovieVoucherItemSectionView(
                            movieImage: movie?.posterPath ?? "",
                            movieName: movie?.title ?? "",
                          ),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    DottedLineSectionView(),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    MovieVoucherInfoDetailsSectionView(
                      check: checkoutVO,
                      theatre: userChooseCinema,
                    ),
                    DottedLineSectionView(),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    BarCodeSectionView(),
                  ],
                ),
              ),

              // QrImage(
              //   data: "1234567890",
              //   version: QrVersions.auto,
              //   size: 70.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}



class VoucherHeadingTitleSectionView extends StatelessWidget {
  const VoucherHeadingTitleSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(
          'Awesome!',
          textColor: Colors.black,
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        BlurTitleText('This is your ticket', MOVIE_CINEMA_COLOR),
      ],
    );
  }
}

class BarCodeSectionView extends StatelessWidget {
  const BarCodeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
      height: MediaQuery.of(context).size.height / 10,
      child: SfBarcodeGenerator(value: 'https://www.padc.com.mm'),
    );
  }
}

class MovieVoucherInfoDetailsSectionView extends StatelessWidget {
  CheckoutVO? check;
  String theatre;

  MovieVoucherInfoDetailsSectionView({
    required this.check,
    required this.theatre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width,

      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: MARGIN_MEDIUM, horizontal: MARGIN_MEDIUM_2),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            MovieVoucherInfoView('Booking no', check?.bookingNo ?? ""),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            MovieVoucherInfoView('Show-time Date ', check?.bookingDate ?? ""),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            MovieVoucherInfoView('Theatre', theatre),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            MovieVoucherInfoView('Screen', '2'),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            MovieVoucherInfoView('Row', check?.row ?? ""),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            MovieVoucherInfoView('Seats', check?.seat ?? ""),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            MovieVoucherInfoView('Price', check?.total ?? ""),
          ],
        ),
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

class MovieVoucherInfoView extends StatelessWidget {
  final String label;
  final String text;

  MovieVoucherInfoView(this.label, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: MOVIE_CINEMA_COLOR, fontSize: TEXT_SMALL_1X),
        ),
        Spacer(),
        Flexible(
          flex: 0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: TEXT_SMALL_1X,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieVoucherItemSectionView extends StatelessWidget {
  final String movieImage;
  final String movieName;

  MovieVoucherItemSectionView(
      {required this.movieImage, required this.movieName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VoucherMovieImageView(
          movieImage: movieImage,
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        VoucherMovieTitleAndDurationView(
          movieName: movieName,
        ),
      ],
    );
  }
}

class VoucherMovieTitleAndDurationView extends StatelessWidget {
  final String movieName;

  VoucherMovieTitleAndDurationView({required this.movieName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieName,
            style: TextStyle(
                color: Colors.black,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Text(
            '105min -1MAX',
            style:
                TextStyle(color: MOVIE_CINEMA_COLOR, fontSize: TEXT_SMALL_1X),
          ),
        ],
      ),
    );
  }
}

class VoucherMovieImageView extends StatelessWidget {
  final String movieImage;

  VoucherMovieImageView({required this.movieImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        image: DecorationImage(
          image: NetworkImage('$IMAGE_BASE_URL$movieImage'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
