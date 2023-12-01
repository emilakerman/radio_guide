import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/src/constants/app_colors.dart';
import 'package:radio_guide/src/constants/app_sizes.dart';
import 'package:radio_guide/src/features/start/presentation/start_page_controller.dart';
import 'package:radio_guide/src/routing/app_routes.dart';
import 'package:radio_guide/src/common_widgets/logo_faded.dart';

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
              child: const AnimatedLogo(),
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
    return Consumer(
      builder: (_, ref, __) {
        Widget buildRandomStarIcon() {
          return _buildStarIcon(
            color:
                ref.read(startPageControllerProvider.notifier).randomizeColor(),
          );
        }

        ref.watch(startPageControllerProvider);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Image(
              width: Sizes.p88,
              height: Sizes.p88,
              image: AssetImage("assets/images/arrow_down.png"),
            ),
            Column(
              children: [
                buildRandomStarIcon(),
                gapH80,
                buildRandomStarIcon(),
              ],
            ),
            Column(
              children: [
                buildRandomStarIcon(),
                gapH16,
                buildRandomStarIcon(),
                gapH8,
                buildRandomStarIcon(),
              ],
            ),
            Column(
              children: [
                gapH4,
                buildRandomStarIcon(),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStarIcon({required Color? color}) {
    return Icon(
      Icons.star,
      color: color,
    );
  }
}
