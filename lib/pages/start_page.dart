import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
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
              padding: EdgeInsets.only(left: 25),
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
                  SizedBox(
                    height: 10,
                  ),
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 50,
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
        const Image(width: 90, height: 90, image: AssetImage("assets/images/arrow_down.png")),
        Column(
          children: [
            _buildStarIcon(color: AppColors.additional),
            const SizedBox(height: 80),
            _buildStarIcon(color: AppColors.secondary),
          ],
        ),
        Column(
          children: [
            _buildStarIcon(color: AppColors.secondary),
            const SizedBox(height: 18),
            _buildStarIcon(color: AppColors.complement),
            const SizedBox(height: 5),
            _buildStarIcon(color: AppColors.additional),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 5),
            _buildStarIcon(color: AppColors.complement),
          ],
        ),
      ],
    );
  }

  Icon _buildStarIcon({required Color? color}) {
    return Icon(
      Icons.star,
      color: color,
    );
  }
}
