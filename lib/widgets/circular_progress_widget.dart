import 'package:flutter/material.dart';
import 'package:radio_guide/constants/app_colors.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.secondary,
        strokeWidth: 5,
      ),
    );
  }
}
