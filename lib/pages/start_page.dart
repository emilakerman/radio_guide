import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/routing/app_routes.dart';

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
            Container(
              color: AppColors.secondary,
              child: const Image(
                image: AssetImage("assets/images/sr.png"),
              ),
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
            const Icon(Icons.arrow_downward),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => context.goNamed(AppRoutes.channels.name),
                child: const Text("Lets go"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.additional,
                  elevation: 4,
                  shadowColor: AppColors.black,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
