import 'package:equatable/equatable.dart';
import 'package:movies_and_tv_store/src/model/movie.dart';

abstract class MovieState extends Equatable{
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState{}

class MovieLoaded extends MovieState{
  final List<Movie> movieList;
  const MovieLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class MovieError extends MovieState{}