import 'package:demo/constants/app_colors.dart';
import 'package:demo/constants/app_strings.dart';
import 'package:demo/constants/dimensions.dart';
import 'package:demo/data/hive/employee_data_model.dart';
import 'package:demo/theme/style.dart';
import 'package:demo/ui/home_page/add_employee/add_employee_bloc/add_employee_bloc.dart';
import 'package:demo/ui/home_page/add_employee/helper_widegts.dart';
import 'package:demo/utils/show_dialog_util.dart';
import 'package:demo/utils/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum EmployeeRole { Manager, Developer, Designer, Tester }

class UpdateEmployeePageArg {
  bool isEditMode;
  EmployeeDBEntry? employeeDetails;

  UpdateEmployeePageArg({
    this.isEditMode = false,
    this.employeeDetails,
  });
}

class AddEmployeePage extends StatelessWidget {
  static const routeName = '/AddEmployeePage';

  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as UpdateEmployeePageArg;
    return BlocProvider(
      create: (_) => AddEmployeeBloc(),
      child: _AddEmployeePage(
        isEditMode: arg.isEditMode,
        employeeDetails: arg.employeeDetails,
      ),
    );
  }
}

class _AddEmployeePage extends StatefulWidget {
  final bool isEditMode;
  final EmployeeDBEntry? employeeDetails;

  const _AddEmployeePage(
      {Key? key, required this.isEditMode, this.employeeDetails})
      : super(key: key);

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<_AddEmployeePage> {
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<EmployeeRole?> _selectedRole =
      ValueNotifier<EmployeeRole?>(null);
  final ValueNotifier<DateTime?> _startDate =
      ValueNotifier<DateTime?>(DateTime.now());
  final ValueNotifier<DateTime?> _endDate = ValueNotifier<DateTime?>(null);

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.employeeDetails != null) {
      _nameController.text = widget.employeeDetails!.employeeName;
      _selectedRole.value = EmployeeRole.values.firstWhere(
        (role) => role.name == widget.employeeDetails!.role,
        orElse: () => EmployeeRole.Developer,
      );
      _startDate.value = widget.employeeDetails!.startDate;
      _endDate.value = widget.employeeDetails!.endDate;
    }
  }

  void _onSave() {
    if (_nameController.text.isEmpty ||
        _selectedRole.value == null ||
        _startDate.value == null ||
        _endDate.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.kMandatoryFieldsMsg),
          backgroundColor: AppColors.kRedColor,
        ),
      );
      return;
    }

    EmployeeDBEntry emp = EmployeeDBEntry(
      id: widget.employeeDetails?.id,
      employeeName: _nameController.text,
      role: _selectedRole.value!.name,
      startDate: _startDate.value!,
      endDate: _endDate.value!,
    );

    final previousDetails = widget.employeeDetails;
    if (widget.isEditMode &&
        emp.employeeName == previousDetails?.employeeName &&
        emp.role == previousDetails?.role &&
        emp.endDate == previousDetails?.endDate &&
        emp.startDate == previousDetails?.startDate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.kNoChangesMsg),
          backgroundColor: AppColors.kOrangeColor,
        ),
      );
      return;
    }

    final event = widget.isEditMode
        ? EditEmployeeDataEvent(employeeEntry: emp)
        : SaveEmployeeDataEvent(employeeEntry: emp);
    BlocProvider.of<AddEmployeeBloc>(context).add(event);
  }

  Widget buildDateSelection(BuildContext context, String label,
      ValueNotifier<DateTime?> dateNotifier) {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: dateNotifier,
      builder: (context, value, child) {
        return TextButton.icon(
          icon: const Icon(Icons.calendar_today),
          label: Text(
              value != null ? DateFormat('yyyy-MM-dd').format(value) : label),
          onPressed: () => selectDate(
              context, label == AppStrings.kStartDate, _startDate, _endDate),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.isEditMode
              ? AppStrings.kEditEmpDetails
              : AppStrings.kAddEmpDetails,
          style: context.textTheme.headline6Regular
              .copyWith(color: AppColors.kWhiteColor),
        ),
        backgroundColor: AppColors.kBlueBg,
        actions: widget.isEditMode
            ? [
                const Padding(
                  padding: EdgeInsets.only(right: px_16),
                  child: Icon(Icons.delete, color: AppColors.white),
                ).ripple(onPressed: () {
                  BlocProvider.of<AddEmployeeBloc>(context).add(
                      DeleteExistingEmployeeEvent(
                          employeeId: widget.employeeDetails!.id!));
                }),
              ]
            : null,
      ),
      body: BlocListener<AddEmployeeBloc, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeLoadingState) {
            DialogUtil.showDialogWithMessage(context, "",
                isLoading: true, onTap: () {});
          } else if (state is AddEmployeeSuccessState) {
            Navigator.pop(context);
            DialogUtil.showDialogWithMessage(context, state.msg, onTap: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            });
          } else if (state is AddEmployeeFailedState) {
            Navigator.pop(context);
            DialogUtil.showDialogWithMessage(
                context, AppStrings.kSomethingWentWrong, onTap: () {
              Navigator.pop(context, false);
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(px_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: AppStrings.kEmployeeName,
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: px_16),
              ValueListenableBuilder<EmployeeRole?>(
                valueListenable: _selectedRole,
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () => showRoleSelectionSheet(context, _selectedRole),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: AppStrings.kSelectRole,
                        border: OutlineInputBorder(),
                      ),
                      child: Text(value != null
                          ? value.toString().split('.').last
                          : AppStrings.kSelectRole),
                    ),
                  );
                },
              ),
              const SizedBox(height: px_16),
              Row(
                children: [
                  Expanded(
                      child: buildDateSelection(
                          context, AppStrings.kStartDate, _startDate)),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                      child: buildDateSelection(
                          context, AppStrings.kEndDate, _endDate)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: double.infinity, maxWidth: double.infinity),
        child: Padding(
          padding: const EdgeInsets.all(px_16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(px_8),
                  ),
                  backgroundColor: Colors.indigo[50],
                  foregroundColor: Colors.blue,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text(AppStrings.kCancel),
              ),
              const SizedBox(width: px_8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(px_8),
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: _onSave,
                child: const Text(AppStrings.kSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
