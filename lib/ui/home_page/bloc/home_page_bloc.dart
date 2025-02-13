import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo/data/hive/employee_data_model.dart';
import 'package:demo/data/sqflite/table/employee_table/employee_data_table.dart';
import 'package:demo/utils/logger.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

const _kTag = "HomePageBloc";

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  int currentLayer = 0;
  late EmployeeTableProvider dbProvider;

  HomePageBloc() : super(HomePageLoadingState()) {
    dbProvider = EmployeeTableProvider();

    on<FetchEmployeeDataEvent>(_fetchEmployeeData);
    on<DeleteEmployeeDataEvent>(_deleteEmployeeData);
    on<UndoSaveEmployeeDataEvent>(_saveEmployeeData);
  }

  ///this method will be responsible for fetching the data from network
  /// API call to DIO client will be initiated from this method
  /// try - catch block will be used with network call
  /// As of now we are using local DATABASE (SQFLite)
  /// hence fetching the same instead of network data

  Future<FutureOr<void>> _fetchEmployeeData(
      FetchEmployeeDataEvent event, Emitter<HomePageState> emit) async {
    try {
      emit(HomePageLoadingState());
      final List<EmployeeDBEntry> dbEntries = await dbProvider.getAllData();

      emit(HomePageSuccessState(dbEntries: dbEntries));
    } catch (e, stack) {
      Logger.info(_kTag, e, stack);
      emit(HomePageFailedState());
    }
  }

  Future<FutureOr<void>> _deleteEmployeeData(
      DeleteEmployeeDataEvent event, Emitter<HomePageState> emit) async {
    try {
      emit(HomePageLoadingState());
      await dbProvider.deleteEmployeeEntry(event.employeeId);
      final List<EmployeeDBEntry> dbEntries = await dbProvider.getAllData();

      emit(HomePageSuccessState(dbEntries: dbEntries));
    } catch (e, stack) {
      Logger.info(_kTag, e, stack);
      emit(HomePageFailedState());
    }
  }

  Future<FutureOr<void>> _saveEmployeeData(
      UndoSaveEmployeeDataEvent event, Emitter<HomePageState> emit) async {
    try {
      emit(HomePageLoadingState());
      final res = await dbProvider.insertEmpData(event.employeeEntry);
      if (res != null) {
        add(FetchEmployeeDataEvent());
      } else {
        emit(HomePageFailedState());
      }
    } catch (e, stack) {
      Logger.info(_kTag, e, stack);
      emit(HomePageFailedState());
    }
  }
}
