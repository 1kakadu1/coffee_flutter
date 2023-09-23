import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

SnackBar snackBar(String msg,
    {bool? isLoad,
    bool? fullWidth,
    BuildContext? ctx,
    Widget? loader,
    Duration? duration,
    BorderRadius? borderRadius}) {
  final load = Row(children: [
    loader ??
        CircularProgressIndicator(
          color: AppColors.red[200],
          strokeWidth: 4.0,
        ),
    const SizedBox(
      width: 12,
    )
  ]);
  return SnackBar(
    content: Row(
      children: [
        isLoad == true ? load : const SizedBox(),
        Expanded(flex: 1, child: Text(msg))
      ],
    ),
    duration: duration ?? const Duration(milliseconds: 2000),
    width: fullWidth == true && ctx != null
        ? MediaQuery.of(ctx).size.width
        : 310.0, // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(10.0),
    ),
  );
}
