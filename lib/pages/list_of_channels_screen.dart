import 'package:flutter/material.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/sr_api_services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:radio_guide/widgets/channel_list.dart';
import 'package:radio_guide/widgets/circular_progress_widget.dart';
import 'package:radio_guide/widgets/floating_action_buttons.dart';

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
  bool _isLoading = true;

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
    setState(() => _isLoading = true);
    List<dynamic>? list = await apiController.fetchChannels();
    setState(() {
      channels = list;
      _isLoading = false;
    });
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
      body: _isLoading
          ? CircularProgressWidget()
          : ChannelList(
              channels: channels,
              isFavorite: false,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFABRow(context: context),
    );
  }
}
