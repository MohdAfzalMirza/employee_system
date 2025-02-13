import 'package:hive/hive.dart';

part 'employee_data_model.g.dart';

@HiveType(typeId: 0)
class EmployeeDBEntry {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String employeeName;

  @HiveField(2)
  String role;

  @HiveField(3)
  DateTime startDate;

  @HiveField(4)
  DateTime endDate;

  EmployeeDBEntry({
    this.id,
    required this.employeeName,
    required this.role,
    required this.startDate,
    required this.endDate,
  });

  factory EmployeeDBEntry.fromJson(Map<String, dynamic> json) {
    return EmployeeDBEntry(
      id: json['id'],
      employeeName: json['employeeName'],
      role: json['role'],
      startDate: DateTime.parse(json['startDate']),
      // Convert from String
      endDate: DateTime.parse(json['endDate']), // Convert from String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'role': role,
      'startDate': startDate.toIso8601String(), // Convert to String
      'endDate': endDate.toIso8601String(), // Convert to String
    };
  }
}
