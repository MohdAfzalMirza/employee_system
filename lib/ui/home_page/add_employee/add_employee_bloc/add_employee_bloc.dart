import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo/constants/app_strings.dart';
import 'package:demo/data/sqflite/table/employee_table/employee_data_table.dart';
import 'package:demo/model/employee_data_model.dart';
import 'package:demo/utils/logger.dart';
import 'package:meta/meta.dart';

part 'add_employee_event.dart';

part 'add_employee_state.dart';

///this block is responsible for
///Insert employee data in DB
///Update data of particular employee

const _kTag = "HomePageBloc";

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  late EmployeeTableProvider dbProvider;

  AddEmployeeBloc() : super(AddEmployeeInitialState()) {
    dbProvider = EmployeeTableProvider();
    on<SaveEmployeeDataEvent>(_saveEmployeeData);
    on<EditEmployeeDataEvent>(_updateEmployeeData);
    on<DeleteExistingEmployeeEvent>(_deleteEmployeeData);
  }

  Future<FutureOr<void>> _saveEmployeeData(
      SaveEmployeeDataEvent event, Emitter<AddEmployeeState> emit) async {
    try {
      emit(AddEmployeeLoadingState());
      final res = await dbProvider.insertEmpData(event.employeeEntry);
      if (res != null) {
        emit(AddEmployeeSuccessState(msg: AppStrings.kDataInsertedSuccessMsg));
      } else {
        emit(AddEmployeeFailedState());
      }
    } catch (e, stack) {
      Logger.info(_kTag, e, stack);
      emit(AddEmployeeFailedState());
    }
  }

  Future<FutureOr<void>> _updateEmployeeData(
      EditEmployeeDataEvent event, Emitter<AddEmployeeState> emit) async {
    try {
      emit(AddEmployeeLoadingState());
      await dbProvider.updateEmployeeEntry(event.employeeEntry);

      emit(AddEmployeeSuccessState(msg: AppStrings.kDataUpdatedSuccessMsg));
    } catch (e, stack) {
      Logger.info(_kTag, e, stack);
      emit(AddEmployeeFailedState());
    }
  }

  Future<FutureOr<void>> _deleteEmployeeData(
      DeleteExistingEmployeeEvent event, Emitter<AddEmployeeState> emit) async {
    try {
      emit(AddEmployeeLoadingState());
      await dbProvider.deleteEmployeeEntry(event.employeeId);

      emit(AddEmployeeSuccessState(msg: AppStrings.kDataDeletedSuccessMsg));
    } catch (e, stack) {
      Logger.info(_kTag, e, stack);
      emit(AddEmployeeFailedState());
    }
  }
}
