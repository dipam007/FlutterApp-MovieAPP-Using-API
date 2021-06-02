import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable{
  const MovieDetailEvent();
}

class MovieDetailEventStarted extends MovieDetailEvent{
  final int id;

  const MovieDetailEventStarted(this.id);

  @override
  List<Object> get props => [];
}