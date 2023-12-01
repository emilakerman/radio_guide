import 'package:flutter/material.dart';
import 'package:radio_guide/src/constants/app_colors.dart';

class GlobalSnackBar {
  final bool isAdded;

  const GlobalSnackBar({
    required this.isAdded,
  });

  static show(
    BuildContext context,
    bool isAdded,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content:
            Text(isAdded ? "Added to favorites!" : "Removed from favorites!"),
        duration: const Duration(seconds: 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        backgroundColor: AppColors.additional,
        action: SnackBarAction(
          textColor: AppColors.white,
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}
