import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_and_tv_store/src/bloc/personbloc/person_event.dart';
import 'package:movies_and_tv_store/src/bloc/personbloc/person_state.dart';
import 'package:movies_and_tv_store/src/model/person.dart';
import 'package:movies_and_tv_store/src/service/api_service.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonLoading());

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async*{
    if(event is PersonEventStarted){
      yield* _mapMovieEventStateToState();
    }
  }
}

Stream<PersonState> _mapMovieEventStateToState() async*{
  final apiRepository = ApiService();
  yield PersonLoading();
  try{
    final List<Person> movies = await apiRepository.getTrendingPerson();

    yield PersonLoaded(movies);
  }catch (_){
    print(_);
    yield PersonError();
  }
}