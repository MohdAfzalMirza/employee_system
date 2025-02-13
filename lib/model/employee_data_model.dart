// import 'package:demo/data/sqflite/table/employee_table/employee_data_table.dart';
//
// class EmployeeDBEntry {
//   late final int? id;
//   final String employeeName;
//   final String role;
//   final DateTime? startDate;
//   final DateTime? endDate;
//
//   EmployeeDBEntry({
//     this.id,
//     required this.employeeName,
//     required this.role,
//     required this.startDate,
//     this.endDate,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       kEmployeeId: id,
//       kEmployeeName: employeeName,
//       kRole: role,
//       kStartDate: startDate?.toIso8601String(),
//       kEndDate: endDate?.toIso8601String(),
//     };
//   }
//
//   factory EmployeeDBEntry.fromJson(Map<String, dynamic> map) {
//     return EmployeeDBEntry(
//       id: map[kEmployeeId] as int?,
//       employeeName: map[kEmployeeName] as String,
//       role: map[kRole] as String,
//       startDate:
//       map[kStartDate] != null ? DateTime.parse(map[kStartDate]) : null,
//       endDate: map[kEndDate] != null ? DateTime.parse(map[kEndDate]) : null,
//     );
//   }
// }
//
