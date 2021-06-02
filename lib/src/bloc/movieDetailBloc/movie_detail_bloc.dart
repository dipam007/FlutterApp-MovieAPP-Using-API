import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_and_tv_store/src/bloc/movieDetailBloc/movie_detail_event.dart';
import 'package:movies_and_tv_store/src/bloc/movieDetailBloc/movie_detail_state.dart';
import 'package:movies_and_tv_store/src/model/movie_detail.dart';
import 'package:movies_and_tv_store/src/service/api_service.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailLoading());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async*{
    if(event is MovieDetailEventStarted){
      yield* _mapMovieEventStateToState(event.id);
    }
  }
}

Stream<MovieDetailState> _mapMovieEventStateToState(int id) async*{
  final apiRepository = ApiService();
  yield MovieDetailLoading();
  try{
    final movieDetail = await apiRepository.getMovieDetail(id);

    yield MovieDetailLoaded(movieDetail);
  } on Exception catch (e){
    print(e);
    yield MovieDetailError();
  }
}