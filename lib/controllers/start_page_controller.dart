import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_page_controller.g.dart';

@riverpod
class StartPageController extends _$StartPageController {
  @override
  Color? build() {
    startRandomizing();
    return randomizeColor();
  }

  Color randomizeColor() {
    return AppColors.colorList[Random().nextInt(AppColors.colorList.length)];
  }

  void startRandomizing() {
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      state = randomizeColor();
    });
  }
}
