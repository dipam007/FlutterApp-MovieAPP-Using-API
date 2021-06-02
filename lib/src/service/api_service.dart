import 'package:dio/dio.dart';
import 'package:movies_and_tv_store/src/model/cast_list.dart';
import 'package:movies_and_tv_store/src/model/movie.dart';
import 'package:movies_and_tv_store/src/model/genre.dart';
import 'package:movies_and_tv_store/src/model/movie_detail.dart';
import 'package:movies_and_tv_store/src/model/movie_image.dart';
import 'package:movies_and_tv_store/src/model/person.dart';

class ApiService{
  final Dio _dio = Dio();
//https://api.themoviedb.org/3/movie/550?
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=f8029c8d1c0a8fc235a2f0a59c210e90';

  Future<List<Movie>> getNowPlayingMovie() async{
    try{
      final url = '$baseUrl/movie/now_playing?$apiKey';
      print("Api Call");
        final response = await _dio.get(url);
        var movies = response.data['results'] as List;
        List<Movie> movieList = movies.map((m)=>Movie.fromJson(m)).toList();
        return movieList;
    }catch(err, stacktrace){
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int movieId) async{
    try{
      final url = '$baseUrl/discover/movie?with_generes=$movieId&&$apiKey';
      print("Api Call");
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m)=>Movie.fromJson(m)).toList();
      return movieList;
    }catch(err, stacktrace){
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenreList() async{
    try{
      final url = '$baseUrl/genre/movie/list?$apiKey';
      final response = await _dio.get(url);
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g)=>Genre.fromJson(g)).toList();
      return genreList;
    }catch(err, stacktrace){
      print(err);
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

  Future<List<Person>> getTrendingPerson() async{
    try{
      final url = '$baseUrl/trending/person/week?$apiKey';
      final response = await _dio.get(url);
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p)=>Person.fromJson(p)).toList();
      return personList;
    }catch(err, stacktrace){
      print(err);
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async{
    try{
      final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);

      movieDetail.trailerId = await getYoutubeId(movieId);
      movieDetail.movieImage = await getMovieImage(movieId);
      movieDetail.castList = await getCastList(movieId);

      return movieDetail;
    }catch(err, stacktrace){
      print(err);
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async{
    try{
      final response = await _dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];

      return youtubeId;
    }catch(err, stacktrace){
      print(err);
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

  Future<MovieImage> getMovieImage(int movieId) async{
    try{
      final response = await _dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      return MovieImage.fromJson(response.data);
    }catch(err, stacktrace){
      print(err);
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async{
    try{
      final response = await _dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> mycastList = list.map((e) => Cast.fromJson(e)).toList();

      return mycastList;
    }catch(err, stacktrace){
      print(err);
      throw Exception('Exception accoured: $err with stacktrace: $stacktrace');
    }
  }

}

// I/flutter ( 5051): Trending: 11111111111111111111111111111111111111111111
// I/flutter ( 5051): [{release_date: 2021-05-26, adult: false, backdrop_path: /2sbe8qmdYNLQ8wprAXKDNTMbylZ.jpg, genre_ids: [35, 80], vote_count: 880, original_language: en, id: 337404, poster_path: /hjS9mH8KvRiGHgjk6VUZH7OT0Ng.jpg, title: Cruella, video: false, vote_average: 8.8, original_title: Cruella, overview: In 1970s London amidst the punk rock revolution, a young grifter named Estella is determined to make a name for herself with her designs. She befriends a pair of young thieves who appreciate her appetite for mischief, and together they are able to build a life for themselves on the London streets. One day, Estella’s flair for fashion catches the eye of the Baroness von Hellman, a fashion legend who is devastatingly chic and terrifyingly haute. But their relationship sets in motion a course of events and revelations that will cause Estella to embrace her wicked side and become the raucous, fashionable and revenge-bent Cruella., popularity: 2225.889, media_type: movie}, {adult: false, backdrop_path: /hP7dN2B5ztQgSIN5Qv
// I/flutter ( 5051): Top Movies: 2222222222222222222222222222222222222222222
// I/flutter ( 5051): [{adult: false, backdrop_path: /2sbe8qmdYNLQ8wprAXKDNTMbylZ.jpg, genre_ids: [35, 80], id: 337404, original_language: en, original_title: Cruella, overview: In 1970s London amidst the punk rock revolution, a young grifter named Estella is determined to make a name for herself with her designs. She befriends a pair of young thieves who appreciate her appetite for mischief, and together they are able to build a life for themselves on the London streets. One day, Estella’s flair for fashion catches the eye of the Baroness von Hellman, a fashion legend who is devastatingly chic and terrifyingly haute. But their relationship sets in motion a course of events and revelations that will cause Estella to embrace her wicked side and become the raucous, fashionable and revenge-bent Cruella., popularity: 2225.889, poster_path: /hjS9mH8KvRiGHgjk6VUZH7OT0Ng.jpg, release_date: 2021-05-26, title: Cruella, video: false, vote_average: 8.8, vote_count: 880}, {adult: false, backdrop_path: /gNBCvtYyGPbjPCT1k3MvJuNuXR6.jpg, genr
// I/flutter ( 5051): TV popular Shows: 3333333333333333333333333333333333333
// I/flutter ( 5051): [{backdrop_path: /h48Dpb7ljv8WQvVdyFWVLz64h4G.jpg, first_air_date: 2016-01-25, genre_ids: [80, 10765], id: 63174, name: Lucifer, origin_country: [US], original_language: en, original_name: Lucifer, overview: Bored and unhappy as the Lord of Hell, Lucifer Morningstar abandoned his throne and retired to Los Angeles, where he has teamed up with LAPD detective Chloe Decker to take down criminals. But the longer he's away from the underworld, the greater the threat that the worst of humanity could escape., popularity: 2045.499, poster_path: /4EYPN5mVIhKLfxGruy7Dy41dTVn.jpg, vote_average: 8.5, vote_count: 8878}, {backdrop_path: /9Jmd1OumCjaXDkpllbSGi2EpJvl.jpg, first_air_date: 2014-10-07, genre_ids: [18, 10765], id: 60735, name: The Flash, origin_country: [US], original_language: en, original_name: The Flash, overview: After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma. Months later he awakens with the power of super speed, granting him the