import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static void showDialogWithMessage(BuildContext context, String message,
      {bool isLoading = false, required Function() onTap}) {
    showDialog(
      context: context,
      barrierDismissible: !isLoading,
      builder: (context) => AlertDialog(
        content: isLoading
            ? const Center(
                heightFactor: 2,
                child: CupertinoActivityIndicator(radius: 15),
              )
            : Text(message),
        actions: isLoading
            ? null
            : [
                TextButton(
                  onPressed:  onTap,
                  child: const Text("OK"),
                ),
              ],
      ),
    );
  }
}
