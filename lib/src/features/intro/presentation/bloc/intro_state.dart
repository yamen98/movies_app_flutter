part of 'intro_bloc.dart';

@immutable
abstract class IntroState {}

class IntroInitial extends IntroState {}

/// --------------------Start Get Data-------------------- ///

/// Loading login state
class LoadingGetDataState extends IntroState {}

/// Error login state
class ErrorGetDataState extends IntroState {
  final String errorMsg;

  ErrorGetDataState(this.errorMsg);
}

/// Success login state
class SuccessGetDataState extends IntroState {}

/// --------------------End GetData-------------------- ///
