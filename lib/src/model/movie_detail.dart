import 'package:movies_and_tv_store/src/model/cast_list.dart';
import 'package:movies_and_tv_store/src/model/movie_image.dart';

class MovieDetail{
  final String id;
  final String title;
  final String backdropPath;
  final String budget;
  final String homepage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runtime;
  final String voteAverage;
  final String voteCount;

  String trailerId;

  MovieImage movieImage;

  List<Cast> castList;

  MovieDetail(
      {this.id,
      this.title,
      this.backdropPath,
      this.budget,
      this.homepage,
      this.originalTitle,
      this.overview,
      this.releaseDate,
      this.runtime,
      this.voteAverage,
      this.voteCount
   });

  factory MovieDetail.fromJson(dynamic json){
    if(json==null)
      return MovieDetail();

    return MovieDetail(
      id: json['id'].toString(),
      title: json['title'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'].toString(),
      homepage: json['home_page'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'].toString(),
      voteAverage: json['vote_average'].toString(),
      voteCount: json['vote_count'].toString(),
    );
  }

}