import 'package:demo/data/hive/employee_data_model.dart';
import 'package:hive/hive.dart';

const kEmployeeBox = "employee_table";

class EmployeeTableProvider {
  static final EmployeeTableProvider _instance =
      EmployeeTableProvider.internal();

  factory EmployeeTableProvider() => _instance;

  EmployeeTableProvider.internal();

  Box<EmployeeDBEntry>? _box; // Store the opened Hive box

  /// Initialize Hive box (called only once)
  Future<void> init() async {
    _box = await Hive.openBox<EmployeeDBEntry>(kEmployeeBox);
  }

  /// Ensure box is opened before use
  Future<Box<EmployeeDBEntry>> _openBox() async {
    if (_box == null) {
      await init();
    }
    return _box!;
  }

  Future<int> insertEmpData(EmployeeDBEntry employeeData) async {
    final box = await _openBox();
    int id = (box.keys.isNotEmpty ? box.keys.last as int : 0) + 1;
    employeeData.id = id;
    await box.put(id, employeeData);
    return id;
  }

  Future<List<EmployeeDBEntry>> getAllData() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<int> getTotalNumberOfEntriesInDB() async {
    final box = await _openBox();
    return box.length;
  }

  Future<EmployeeDBEntry?> getEmployeeEntry(int id) async {
    final box = await _openBox();
    return box.get(id);
  }

  Future<void> deleteEmployeeEntry(int id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  Future<void> updateEmployeeEntry(EmployeeDBEntry empData) async {
    final box = await _openBox();
    await box.put(empData.id, empData);
  }

  Future<void> deleteAllData() async {
    final box = await _openBox();
    await box.clear();
  }
}
