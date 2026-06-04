import 'package:moviehub/services/api_services.dart';

class Movie {
  final int id;
  final String title;
  final String backDropath;
  final String releseDate;
  final String overView;
  final String posterPath;
  final double voteAverage;


  Movie({
    required this.id,
    required this.backDropath,
    required this.overView,
    required this.posterPath,
    required this.releseDate,
    required this.title,
    required this.voteAverage
   
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
     
      backDropath: json['backdrop_path'] ?? '',
      overView: json['overview'] ?? 'No Overview',
      posterPath: json['poster_path'],
      releseDate: json['release_date'],
      title: json['title'] ?? ['original_title'] ?? [],
       voteAverage: (json['vote_average'] ?? 0).toDouble(),

    );
  }

  String get fullPosterUrl {
    return posterPath.isNotEmpty
        ? '${ApiServices.imageBaseurl}$posterPath'
        : 'https://via.placeholder.com/500x750?text=No+Image';
  }

  String get fullBackDropUrl {
    return backDropath.isNotEmpty
        ? '${ApiServices.imageBaseurl}$backDropath'
        : 'https://via.placeholder.com/500x750?text=No+Image';
  }
}
