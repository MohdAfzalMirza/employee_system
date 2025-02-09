part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageSuccessState extends HomePageState {
  final List<EmployeeDBEntry> dbEntries;

  HomePageSuccessState({required this.dbEntries});
}

class HomePageFailedState extends HomePageState {}

class HomePageEmptyDataState extends HomePageState {}
