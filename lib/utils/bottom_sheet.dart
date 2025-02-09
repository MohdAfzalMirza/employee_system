import 'package:demo/constants/app_colors.dart';
import 'package:demo/constants/dimensions.dart';
import 'package:flutter/material.dart';

Future<T?> customModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissible = false,
  bool enableDrag = false,
  bool isScrollEnabled = false,
  Color? bgColor = AppColors.white,
  double? elevation,
}) {
  return showModalBottomSheet<T>(
      context: context,
      elevation: elevation,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: AppColors.white,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: isScrollEnabled,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(px_24),
              topRight: Radius.circular(px_24))),
      builder: (context) {
        return child;
      });
}
