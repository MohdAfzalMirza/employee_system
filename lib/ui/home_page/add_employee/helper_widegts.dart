import 'package:demo/constants/app_colors.dart';
import 'package:demo/constants/app_strings.dart';
import 'package:demo/constants/dimensions.dart';
import 'package:demo/ui/home_page/add_employee/add_employee_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectDate(
    BuildContext context,
    bool isStartDate,
    ValueNotifier<DateTime?> startDate,
    ValueNotifier<DateTime?> endDate) async {
  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          DateTime selectedDate = isStartDate
              ? (startDate.value ?? DateTime.now())
              : (endDate.value ?? startDate.value ?? DateTime.now());

          DateTime firstDate = isStartDate
              ? DateTime(2000, 1, 1)
              : (startDate.value ?? DateTime.now());

          void updateDate(DateTime date) {
            setState(() {
              selectedDate = date;
              if (isStartDate) {
                startDate.value = date;
                if (endDate.value != null && endDate.value!.isBefore(date)) {
                  endDate.value = date;
                }
              } else {
                if (date.isBefore(startDate.value!)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(AppStrings.kEndDateError)),
                  );
                  return;
                }
                endDate.value = date;
              }
            });
          }

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(px_20)),
            child: Padding(
              padding: const EdgeInsets.all(px_16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(AppStrings.kSelectDate,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: px_10),
                  SizedBox(
                    height: px_100,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      mainAxisSpacing: px_6,
                      crossAxisSpacing: px_6,
                      shrinkWrap: true,
                      children: [
                        quickSelectButton(
                            AppStrings.kToday, DateTime.now(), updateDate),
                        quickSelectButton(AppStrings.kNextMonday,
                            getNextMonday(), updateDate),
                        quickSelectButton(AppStrings.kNextTuesday,
                            getNextTuesday(), updateDate),
                        quickSelectButton(
                            AppStrings.kAfterOneWeek,
                            DateTime.now().add(const Duration(days: 7)),
                            updateDate),
                      ],
                    ),
                  ),
                  const SizedBox(height: px_4),
                  SizedBox(
                    height: px_300,
                    child: CalendarDatePicker(
                      key: ValueKey(selectedDate),
                      initialDate: selectedDate,
                      firstDate: firstDate,
                      lastDate: DateTime(2101),
                      onDateChanged: updateDate,
                    ),
                  ),
                  const SizedBox(height: px_10),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_today, color: AppColors.kBlue),
                      const SizedBox(width: px_2),
                      Text(
                        DateFormat('d MMM yyyy').format(selectedDate),
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: px_70,
                        height: px_40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4), // Reduce padding
                            minimumSize: const Size(px_70, px_40), // Ensure button size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(px_8),
                            ),
                            backgroundColor: AppColors.kIndigoLight,
                            foregroundColor: AppColors.kBlue,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            AppStrings.kCancel,
                            style: TextStyle(fontSize: 14), // Adjust font size
                            overflow: TextOverflow.ellipsis, // Prevent multi-line text
                          ),
                        ),
                      ),
                      const SizedBox(width: px_4),
                      SizedBox(
                        width: px_70,
                        height: px_40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            minimumSize: const Size(px_70, px_40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(px_8),
                            ),
                            backgroundColor: AppColors.kBlue,
                            foregroundColor: AppColors.kWhite,
                          ),
                          onPressed: () {
                            updateDate(selectedDate);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            AppStrings.kSave,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget quickSelectButton(
    String label, DateTime date, Function(DateTime) updateDate) {
  return ElevatedButton(
    onPressed: () => updateDate(date),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(px_8)),
    ),
    child: Text(label,
        style: const TextStyle(color: AppColors.kWhite, fontSize: px_12)),
  );
}

DateTime getNextMonday() {
  return DateTime.now().add(Duration(days: (8 - DateTime.now().weekday) % 7));
}

DateTime getNextTuesday() {
  return DateTime.now().add(Duration(days: (9 - DateTime.now().weekday) % 7));
}


void showRoleSelectionSheet(
    BuildContext context, ValueNotifier<EmployeeRole?> selectedRole) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(px_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: EmployeeRole.values.map((role) {
            return ListTile(
              title: Text(
                role.toString().split('.').last,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                selectedRole.value = role;
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      );
    },
  );
}