import 'package:flutter/material.dart';
import 'package:radio_guide/src/constants/app_colors.dart';
import 'package:radio_guide/src/utils/shared_preferences.dart';
import 'package:radio_guide/src/features/channel_list/data/sr_api_services.dart';
import 'package:radio_guide/src/common_widgets/channel_list.dart';
import 'package:radio_guide/src/common_widgets/floating_action_buttons.dart';

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
    super.initState();
    fetchData();
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
        ),
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
