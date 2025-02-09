part of 'add_employee_bloc.dart';

@immutable
abstract class AddEmployeeState {}

class AddEmployeeInitialState extends AddEmployeeState {}

class AddEmployeeLoadingState extends AddEmployeeState {}

class AddEmployeeSuccessState extends AddEmployeeState {
  final String msg;
  AddEmployeeSuccessState({required this.msg});
}

class AddEmployeeFailedState extends AddEmployeeState {}
