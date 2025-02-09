part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class FetchEmployeeDataEvent extends HomePageEvent {}

class DeleteEmployeeDataEvent extends HomePageEvent {
  final int employeeId;

  DeleteEmployeeDataEvent({required this.employeeId});
}

class UndoSaveEmployeeDataEvent extends HomePageEvent {
  final EmployeeDBEntry employeeEntry;

  UndoSaveEmployeeDataEvent({required this.employeeEntry});
}