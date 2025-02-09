import 'package:demo/data/sqflite/database_helper.dart';
import 'package:demo/model/employee_data_model.dart';

/// Table Name
const kEmployeeTableName = "employee_table";

/// Table column attributes
const kEmployeeId = "id";
const kEmployeeName = "employeeName";
const kRole = "role";
const kStartDate = "startDate";
const kEndDate = "endDate";

// Table creation command
class EmployeeTableProvider {
  static String createTableCMD = '''
  CREATE TABLE $kEmployeeTableName (
    $kEmployeeId INTEGER PRIMARY KEY AUTOINCREMENT, 
    $kEmployeeName TEXT, 
    $kRole TEXT, 
    $kStartDate TEXT,
    $kEndDate TEXT
  )
  ''';

  static final EmployeeTableProvider _instance =
      EmployeeTableProvider.internal();

  factory EmployeeTableProvider() => _instance;

  EmployeeTableProvider.internal();

  Future<int> insertEmpData(EmployeeDBEntry employeeData) async {
    final dbClient = await DatabaseHelper().db;
    int insertFlag =
        await dbClient.insert(kEmployeeTableName, employeeData.toJson());
    return insertFlag;
  }

  Future<List<EmployeeDBEntry>> getAllData() async {
    final dbClient = await DatabaseHelper().db;
    final res = await dbClient.query(kEmployeeTableName);
    return res.map((e) => EmployeeDBEntry.fromJson(e)).toList();
  }

  Future<int> getTotalNumberOfEntriesInDB() async {
    final dbClient = await DatabaseHelper().db;
    final res = await dbClient.query(kEmployeeTableName);
    List<EmployeeDBEntry> mediaListInDB = [];
    mediaListInDB = res.map((e) => EmployeeDBEntry.fromJson(e)).toList();
    return mediaListInDB.length;
  }

  Future<EmployeeDBEntry?> getEmployeeEntry(int id) async {
    final dbClient = await DatabaseHelper().db;
    final res = await dbClient
        .query(kEmployeeTableName, where: '$kEmployeeId = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      return EmployeeDBEntry.fromJson(res.first);
    }
    return null;
  }

  Future<void> deleteEmployeeEntry(int id) async {
    final dbClient = await DatabaseHelper().db;
    await dbClient
        .delete(kEmployeeTableName, where: '$kEmployeeId = ?', whereArgs: [id]);
  }

  Future<void> updateEmployeeEntry(EmployeeDBEntry empData) async {
    final dbClient = await DatabaseHelper().db;
    await dbClient.update(kEmployeeTableName, empData.toJson(),
        where: '$kEmployeeId = ?', whereArgs: [empData.id]);
  }

  /// Method to delete all entries from the table
  Future<void> deleteAllData() async {
    final dbClient = await DatabaseHelper().db;
    await dbClient.delete(kEmployeeTableName);
  }
}

