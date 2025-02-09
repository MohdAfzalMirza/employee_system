import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget ripple(
          {Function? onPressed,
          BorderRadiusGeometry borderRadius =
              const BorderRadius.all(Radius.circular(5)),
          Color? rippleColor}) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: onPressed != null
                ? TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: rippleColor,
                      shape: RoundedRectangleBorder(borderRadius: borderRadius),
                    ),
                    onPressed: () {
                      if (onPressed != null) {
                        onPressed();
                      }
                    },
                    child: Container())
                : const SizedBox.shrink(),
          )
        ],
      );
}
