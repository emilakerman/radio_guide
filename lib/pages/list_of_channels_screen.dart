import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/routing/app_routes.dart';
import 'package:radio_guide/sr_api_services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:radio_guide/widgets/channel_list.dart';

class ListOfChannelsScreen extends StatefulWidget {
  const ListOfChannelsScreen({super.key});

  @override
  State<ListOfChannelsScreen> createState() => _ListOfChannelsScreenState();
}

class _ListOfChannelsScreenState extends State<ListOfChannelsScreen> {
  List<dynamic>? channels = [];
  ApiServices apiController = ApiServices();
  late AudioPlayer player;
  bool isPlaying = false;

  @override
  void initState() {
    player = AudioPlayer();
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void fetchData() async {
    List<dynamic>? list = await apiController.fetchChannels();
    setState(() => channels = list);
  }

  void playAudio(String url) async {
    player.stop();
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Radiokanaler",
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
        channels: channels,
        isFavorite: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFAB(icon: Icons.list_sharp),
          _buildFAB(icon: Icons.heart_broken),
          _buildFAB(icon: Icons.search),
        ],
      ),
    );
  }

  Widget _buildFAB({required IconData icon}) {
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
}
