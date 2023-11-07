import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => AnimatedLogoState();
}

class AnimatedLogoState extends State<AnimatedLogo> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => opacityLevel = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 3),
          child: const Image(
            image: AssetImage("assets/images/sr.png"),
          ),
        ),
      ],
    );
  }
}
