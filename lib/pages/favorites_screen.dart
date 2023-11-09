import 'package:flutter/material.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/shared_preferences.dart';
import 'package:radio_guide/sr_api_services.dart';
import 'package:radio_guide/widgets/channel_list.dart';
import 'package:radio_guide/widgets/floating_action_buttons.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  ApiServices apiController = ApiServices();
  List<dynamic>? convertedList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    LocallyStoredData data = LocallyStoredData();
    List<dynamic>? list2 = await data.readData();
    setState(() => convertedList = list2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favoritkanaler",
          style: TextStyle(color: AppColors.additional),
        ),
        backgroundColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        leading: const BackButton(
          color: AppColors.secondary,
        ),
      ),
      backgroundColor: AppColors.primary,
      body: ChannelList(
        channels: convertedList,
        isFavorite: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFABRow(context: context),
    );
  }
}
