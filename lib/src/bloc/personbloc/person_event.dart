import 'package:equatable/equatable.dart';

abstract class PersonEvent extends Equatable{
  const PersonEvent();
}

class PersonEventStarted extends PersonEvent{

  const PersonEventStarted();

  @override
  List<Object> get props => [];
}