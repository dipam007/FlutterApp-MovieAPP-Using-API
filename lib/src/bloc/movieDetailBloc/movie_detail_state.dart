import 'package:equatable/equatable.dart';
import 'package:movies_and_tv_store/src/model/movie_detail.dart';

abstract class MovieDetailState extends Equatable{
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState{}

class MovieDetailLoaded extends MovieDetailState{
  final MovieDetail detail;
  const MovieDetailLoaded(this.detail);

  @override
  List<Object> get props => [detail];
}

class MovieDetailError extends MovieDetailState{}