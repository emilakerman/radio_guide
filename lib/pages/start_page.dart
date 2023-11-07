import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/constants/app_sizes.dart';
import 'package:radio_guide/routing/app_routes.dart';
import 'package:radio_guide/widgets/logo_faded.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox.shrink(),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: AnimatedLogo(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: Sizes.p24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "SR\nRadio Guide",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  gapH12,
                  Row(
                    children: [
                      Text(
                          "Some smaller body text about the app\nand what it does lorem ipsum dalar\nother things here."),
                    ],
                  )
                ],
              ),
            ),
            _buildIconCollection(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
              width: double.infinity,
              height: Sizes.p48,
              child: ElevatedButton(
                onPressed: () => context.goNamed(AppRoutes.channels.name),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.additional,
                  elevation: 4,
                  shadowColor: AppColors.black,
                  shape: const StadiumBorder(),
                ),
                child: const Text("Lets go"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCollection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Image(
            width: Sizes.p88, height: Sizes.p88, image: AssetImage("assets/images/arrow_down.png")),
        Column(
          children: [
            _buildStarIcon(color: AppColors.additional),
            gapH80,
            _buildStarIcon(color: AppColors.secondary),
          ],
        ),
        Column(
          children: [
            _buildStarIcon(color: AppColors.secondary),
            gapH16,
            _buildStarIcon(color: AppColors.complement),
            gapH8,
            _buildStarIcon(color: AppColors.additional),
          ],
        ),
        Column(
          children: [
            gapH4,
            _buildStarIcon(color: AppColors.complement),
          ],
        ),
      ],
    );
  }

  Widget _buildStarIcon({required Color? color}) {
    return Icon(
      Icons.star,
      color: color,
    );
  }
}
