import 'package:hive/hive.dart';
import 'package:moviehub/services/api_services.dart';
part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String backDropath;

  @HiveField(3)
  final String releaseDate;

  @HiveField(4)
  final String overview;

  @HiveField(5)
  final String posterPath;

  @HiveField(6)
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.backDropath,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      backDropath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }

  String get fullPosterUrl =>
      posterPath.isNotEmpty
          ? '${ApiServices.imageBaseurl}$posterPath'
          : 'https://via.placeholder.com/500x750';

  String get fullBackDropUrl =>
      backDropath.isNotEmpty
          ? '${ApiServices.imageBaseurl}$backDropath'
          : 'https://via.placeholder.com/500x750';
}