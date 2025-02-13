import 'package:demo/constants/app_colors.dart';
import 'package:demo/constants/app_strings.dart';
import 'package:demo/constants/constant_assets.dart';
import 'package:demo/constants/dimensions.dart';
import 'package:demo/data/hive/employee_data_model.dart';
import 'package:demo/theme/style.dart';
import 'package:demo/ui/home_page/add_employee/add_employee_page.dart';
import 'package:demo/ui/home_page/bloc/home_page_bloc.dart';
import 'package:demo/utils/widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  static const routeName = AppStrings.kHomePageRoute;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomePageBloc()..add(FetchEmployeeDataEvent()),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBlueBg,
        title: Text(
          AppStrings.kEmployeeList,
          style: context.textTheme.headline6Regular
              .copyWith(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is HomePageSuccessState) {
              if (state.dbEntries.isEmpty) {
                return Center(child: SvgPicture.asset(kNoEmployeeData));
              }

              final now = DateTime.now();
              final currentEmployees = state.dbEntries
                  .where((e) => e.endDate == null || e.endDate!.isAfter(now))
                  .toList();
              final previousEmployees = state.dbEntries
                  .where((e) => e.endDate != null && e.endDate!.isBefore(now))
                  .toList();

              final hasCurrentEmployees = currentEmployees.isNotEmpty;
              final hasPreviousEmployees = previousEmployees.isNotEmpty;

              final totalItems = currentEmployees.length +
                  previousEmployees.length +
                  (hasCurrentEmployees ? 1 : 0) +
                  (hasPreviousEmployees ? 1 : 0);

              return ListView.builder(
                itemCount: totalItems,
                itemBuilder: (context, index) {
                  if (index == 0 && hasCurrentEmployees) {
                    return _buildSectionHeader(AppStrings.kCurrentEmployees);
                  }

                  int adjustedIndex = index - (hasCurrentEmployees ? 1 : 0);

                  if (adjustedIndex < currentEmployees.length) {
                    return _buildEmployeeTile(
                        context, currentEmployees[adjustedIndex]);
                  }

                  adjustedIndex -= currentEmployees.length;
                  if (adjustedIndex == 0 && hasPreviousEmployees) {
                    return _buildSectionHeader(AppStrings.kPreviousEmployees);
                  }

                  int prevIndex =
                      adjustedIndex - (hasPreviousEmployees ? 1 : 0);

                  if (prevIndex >= 0 && prevIndex < previousEmployees.length) {
                    return _buildEmployeeTile(
                        context, previousEmployees[prevIndex]);
                  }

                  return const SizedBox();
                },
              );
            } else {
              return Center(
                child: Text(
                  AppStrings.kSomethingWentWrong,
                  style: context.textTheme.headline6Bold
                      .copyWith(color: AppColors.warning500),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic needRefresh = await Navigator.pushNamed(
              context, AddEmployeePage.routeName,
              arguments: UpdateEmployeePageArg());
          if (needRefresh != null && needRefresh is bool && needRefresh) {
            BlocProvider.of<HomePageBloc>(context)
                .add(FetchEmployeeDataEvent());
          }
        },
        backgroundColor: AppColors.kBlueBg,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: px_16, vertical: px_8),
      color: AppColors.kGreyBg,
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildEmployeeTile(BuildContext context, EmployeeDBEntry employee) {
    return Dismissible(
      key: Key(employee.employeeName),
      background: Container(
        color: AppColors.kRed,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: px_20),
        child: const Icon(Icons.delete, color: AppColors.white),
      ),
      onDismissed: (direction) {
        final homePageBloc = context.read<HomePageBloc>();
        homePageBloc.add(DeleteEmployeeDataEvent(employeeId: employee.id!));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(AppStrings.kEmployeeDeleted),
            action: SnackBarAction(
              label: AppStrings.kUndo,
              onPressed: () {
                homePageBloc
                    .add(UndoSaveEmployeeDataEvent(employeeEntry: employee));
              },
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(employee.employeeName),
        subtitle: Text(employee.role),
        trailing: Text(
            DateFormat(AppStrings.kDateFormat).format(employee.startDate!)),
      ).ripple(onPressed: () async {
        UpdateEmployeePageArg arg = UpdateEmployeePageArg(
          isEditMode: true,
          employeeDetails: employee,
        );
        dynamic needRefresh = await Navigator.pushNamed(
            context, AddEmployeePage.routeName,
            arguments: arg);
        if (needRefresh != null && needRefresh is bool && needRefresh) {
          BlocProvider.of<HomePageBloc>(context).add(FetchEmployeeDataEvent());
        }
      }),
    );
  }
}
