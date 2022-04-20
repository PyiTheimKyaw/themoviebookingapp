import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_day_time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_list_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

List<CinemaDayTimeSlotVO> getMockCinemaDayTimeslot() {
  return [
    CinemaDayTimeSlotVO(1, "Cinema I",
        [TimeSlotVO(1, "9:30 AM", true), TimeSlotVO(2, "12:00 PM", false)]),
    CinemaDayTimeSlotVO(2, "Cinema II",
        [TimeSlotVO(15, "10:00 AM", false), TimeSlotVO(16, "1:30 PM", false)]),
    CinemaDayTimeSlotVO(3, "Cinema III", [
      TimeSlotVO(29, "9:30 AM", false),
      TimeSlotVO(30, "12:00 PM", false),
      TimeSlotVO(31, "4:30 PM", false)
    ]),
  ];
}

List<List<MovieSeatVO>> getMockCinemaSeatingPlan() {
  return [
    [
      MovieSeatVO(1, "text", "", "A", 0, false),
      MovieSeatVO(2, "space", "", "A", 0, false),
      MovieSeatVO(3, "taken", "A-2", "A", 2, true),
    ],
    [
      MovieSeatVO(1, "text", "", "B", 0, false),
      MovieSeatVO(2, "taken", "B-1", "B", 2, true),
      MovieSeatVO(3, "available", "B-2", "B", 2, false),
    ],
  ];
}

List<MovieVO> getMockMoviesForTest() {
  return [
    MovieVO(
        adult: false,
        backDropPath: "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
        genreIds: [16, 10751, 35, 14],
        id: 508947,
        originalLanguage: "en",
        originalTitle: "Turning Red",
        overView:
            "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
        popularity: 6268.757,
        posterPath: "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
        releaseDate: "2022-03-10",
        title: "Turning Red",
        video: false,
        voteAverage: 7.5,
        voteCount: 1705,
        isNowPlaying: true,
        isComingSoon: false),
    MovieVO(
        adult: false,
        backDropPath: "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg",
        genreIds: [28, 878, 35, 10751],
        id: 675353,
        originalLanguage: "en",
        originalTitle: "Sonic the Hedgehog 2",
        overView: "sonic",
        popularity: 6050.744,
        posterPath: "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg",
        releaseDate: "2022-03-30",
        title: "Sonic the Hedgehog 2",
        video: false,
        voteAverage: 7.7,
        voteCount: 521,
        isNowPlaying: false,
        isComingSoon: true),
  ];
}

List<CreditVO> getMOckCreditsByMovie() {
  return [
    CreditVO(
        false,
        2,
        2127,
        "Production",
        "James Wan",
        "James Wan",
        7.919,
        "/bNJccMIKzCtYnndcOKniSKCzo5Y.jpg",
        null,
        null,
        "5ac092aa925141602a03de96",
        null,
        "Production",
        "Producer"),
    CreditVO(
        false,
        2,
        6668,
        "Editing",
        "Christian Wagner",
        "Christian Wagner",
        1.62,
        null,
        null,
        null,
        "6081f3872b8a43003fcd0672",
        null,
        "Editing",
        "Editor"),
  ];
}

List<UserVO> getMockProfile() {
  return [
    UserVO(
      2,
      "Admin",
      "cimovie@gmail.com",
      "95943185018",
      357,
      "https://tmba.padc.com.mm/img/lady.png",
      [
        CardVO(1, "Aung Kaung", "8765456789", "08/12", "JCB"),
        CardVO(144, "Aung Kaung", "8765456789", "08/12", "JCB"),
        CardVO(145, "Aung Kaung", "8765456789", "08/12", "JCB"),
      ],
    ),
    UserVO(
      572,
      "aa",
      "aa2@gmail.com",
      "959954354353453453",
      102,
      "/img/avatar4.png",
      [
        CardVO(769, "aa", "12312312312", "12/12", "JCB"),
        CardVO(770, "cc", "12312312312", "12/12", "JCB"),
        CardVO(773, "Pyi Theim Kyaw", "12434324324324", "12/12", "JCB"),
      ],
    ),
  ];
}

List<CardVO> getMockCardList() {
  return [
    CardVO(1, "Aung Kaung", "8765456789", "08/12", "JCB"),
    CardVO(144, "Aung Kaung", "8765456789", "08/12", "JCB"),
    CardVO(145, "Aung Kaung", "8765456789", "08/12", "JCB"),
  ];
}

List<SnackListVO> getMockSnackList() {
  return [
    SnackListVO(
      1,
      "Popcorn",
      "Et dolores eaque officia aut.",
      2,
      "https://tmba.padc.com.mm/img/snack.jpg",
    ),
    SnackListVO(
      2,
      "Smoothies",
      "Voluptatum consequatur aut molestiae soluta nulla.",
      3,
      "https://tmba.padc.com.mm/img/snack.jpg",
    ),
    SnackListVO(
      3,
      "Carrots",
      "At vero et doloribus sint porro ipsum consequatur.",
      4,
      "https://tmba.padc.com.mm/img/snack.jpg",
    ),
  ];
}

List<PaymentMethodVO> getMockPaymentMethod() {
  return [
    PaymentMethodVO(1, "Credit card", "Visa, Master Card, JCB", true),
    PaymentMethodVO(
        2, "Internet Banking (ATM card)", "Visa, Master Card, JCB", false),
    PaymentMethodVO(3, "E-Wallet", "AyaPay, KbzPay, WavePay", false),
  ];
}

List<GenreVO> getMockGenreList() {
  return [
    GenreVO(28, "Action"),
    GenreVO(12, "Adventure"),
    GenreVO(16, "Animation"),
  ];
}
