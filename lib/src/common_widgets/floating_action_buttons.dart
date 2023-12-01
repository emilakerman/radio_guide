import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/src/constants/app_colors.dart';
import 'package:radio_guide/src/features/channel_list/presentation/channel_list_controller.dart';
import 'package:radio_guide/src/routing/app_routes.dart';

Widget buildFABRow({
  required BuildContext context,
  Function? onPressed,
}) {
  bool isOnFavoritePage =
      GoRouter.of(context).routerDelegate.currentConfiguration.fullPath ==
          '/channels/favorites';
  return isOnFavoritePage
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFAB(icon: Icons.list_sharp, context: context),
          ],
        )
      : Row(
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
  return Consumer(
    builder: (_, ref, __) => FloatingActionButton(
      heroTag: null,
      onPressed: () {
        if (icon == Icons.heart_broken) {
          context.goNamed(AppRoutes.favorites.name);
        } else if (icon == Icons.search) {
          ref.read(searchbarControllerProvider.notifier).reverseBool();
        } else if (icon == Icons.list_sharp) {
          context.goNamed(AppRoutes.channels.name);
        }
      },
      backgroundColor: AppColors.secondary,
      child: Icon(icon),
    ),
  );
}
