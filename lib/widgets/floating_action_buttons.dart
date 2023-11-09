import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/routing/app_routes.dart';

Widget buildFABRow({required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildFAB(icon: Icons.list_sharp, context: context),
      _buildFAB(icon: Icons.heart_broken, context: context),
      _buildFAB(icon: Icons.search, context: context),
    ],
  );
}

Widget _buildFAB({
  required IconData icon,
  required BuildContext context,
}) {
  return FloatingActionButton(
    heroTag: null,
    onPressed: () {
      if (icon == Icons.heart_broken) {
        context.goNamed(AppRoutes.favorites.name);
      } else {}
    },
    backgroundColor: AppColors.secondary,
    child: Icon(icon),
  );
}
