part of 'add_employee_bloc.dart';

@immutable
abstract class AddEmployeeEvent {}

class SaveEmployeeDataEvent extends AddEmployeeEvent {
  final EmployeeDBEntry employeeEntry;

  SaveEmployeeDataEvent({required this.employeeEntry});
}

class EditEmployeeDataEvent extends AddEmployeeEvent {
  final EmployeeDBEntry employeeEntry;

  EditEmployeeDataEvent({required this.employeeEntry});
}

class DeleteExistingEmployeeEvent extends AddEmployeeEvent {
  final int employeeId;

  DeleteExistingEmployeeEvent({required this.employeeId});
}