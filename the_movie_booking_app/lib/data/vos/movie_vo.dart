import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_country_vo.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

import 'collection_vo.dart';
import 'genre_vo.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: 'MovieVOAdapter')
class MovieVO {
  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  @HiveField(1)
  String? backDropPath;
  @JsonKey(name: 'genre_ids')
  @HiveField(2)
  List<int>? genreIds;
  @JsonKey(name: 'id')
  @HiveField(3)
  int? id;
  @JsonKey(name: 'original_language')
  @HiveField(4)
  String? originalLanguage;
  @JsonKey(name: 'original_title')
  @HiveField(5)
  String? originalTitle;
  @JsonKey(name: 'overview')
  @HiveField(6)
  String? overView;
  @JsonKey(name: 'popularity')
  @HiveField(7)
  double? popularity;
  @JsonKey(name: 'poster_path')
  @HiveField(8)
  String? posterPath;
  @JsonKey(name: 'release_date')
  @HiveField(9)
  String? releaseDate;
  @JsonKey(name: 'title')
  @HiveField(10)
  String? title;
  @JsonKey(name: 'video')
  @HiveField(11)
  bool? video;
  @JsonKey(name: 'vote_average')
  @HiveField(12)
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  @HiveField(13)
  int? voteCount;
  @JsonKey(name: "belongs_to_collection")
  @HiveField(14)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(15)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(16)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(17)
  String? homePage;

  @JsonKey(name: "imdb_id")
  @HiveField(18)
  String? imdbId;

  @JsonKey(name: "production_companies")
  @HiveField(19)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(20)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "revenue")
  @HiveField(21)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(22)
  int? runTime;

  @JsonKey(name: "spoken_languages")
  @HiveField(23)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(24)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(25)
  String? tagLine;
  @HiveField(26)
  bool? isNowPlaying;
  @HiveField(27)
  bool? isComingSoon;

  MovieVO({
    required this.adult,
    required this.backDropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overView,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homePage,
    this.imdbId,
    this.productionCompanies,
    this.productionCountries,
    this.revenue,
    this.runTime,
    this.spokenLanguages,
    this.status,
    this.tagLine,
    required this.isNowPlaying,
    required this.isComingSoon,
  });

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? "").toList() ?? [];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVO &&
          runtimeType == other.runtimeType &&
          adult == other.adult &&
          backDropPath == other.backDropPath &&
          genreIds == other.genreIds &&
          id == other.id &&
          originalLanguage == other.originalLanguage &&
          originalTitle == other.originalTitle &&
          overView == other.overView &&
          popularity == other.popularity &&
          posterPath == other.posterPath &&
          releaseDate == other.releaseDate &&
          title == other.title &&
          video == other.video &&
          voteAverage == other.voteAverage &&
          voteCount == other.voteCount &&
          belongsToCollection == other.belongsToCollection &&
          budget == other.budget &&
          genres == other.genres &&
          homePage == other.homePage &&
          imdbId == other.imdbId &&
          productionCompanies == other.productionCompanies &&
          productionCountries == other.productionCountries &&
          revenue == other.revenue &&
          runTime == other.runTime &&
          spokenLanguages == other.spokenLanguages &&
          status == other.status &&
          tagLine == other.tagLine &&
          isNowPlaying == other.isNowPlaying &&
          isComingSoon == other.isComingSoon;

  @override
  int get hashCode =>
      adult.hashCode ^
      backDropPath.hashCode ^
      genreIds.hashCode ^
      id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overView.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      video.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode ^
      belongsToCollection.hashCode ^
      budget.hashCode ^
      genres.hashCode ^
      homePage.hashCode ^
      imdbId.hashCode ^
      productionCompanies.hashCode ^
      productionCountries.hashCode ^
      revenue.hashCode ^
      runTime.hashCode ^
      spokenLanguages.hashCode ^
      status.hashCode ^
      tagLine.hashCode ^
      isNowPlaying.hashCode ^
      isComingSoon.hashCode;
}
