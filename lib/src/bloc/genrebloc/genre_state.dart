import 'package:equatable/equatable.dart';
import 'package:movies_and_tv_store/src/model/genre.dart';

abstract class GenreState extends Equatable{
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreLoading extends GenreState{}

class GenreLoaded extends GenreState{
  final List<Genre> genreList;
  const GenreLoaded(this.genreList);

  @override
  List<Object> get props => [genreList];
}

class GenreError extends GenreState{}