import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/constants/fallbacks.dart';
import 'package:radio_guide/controllers/channel_list_controller.dart';
import 'package:radio_guide/routing/app_routes.dart';
import 'package:radio_guide/shared_preferences.dart';

class ChannelList extends StatefulWidget {
  ChannelList({super.key, required this.channels, required this.isFavorite});
  List<dynamic>? channels;
  bool isFavorite;

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  bool isPlaying = false;
  late AudioPlayer player;
  ChannelListController channelListController = ChannelListController();
  LocallyStoredData localStorage = LocallyStoredData();

  @override
  void initState() {
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.channels!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(widget.channels?[index]['image'] ?? Fallbacks.fallbackImage),
          onTap: () {
            if (channelListController.saveOrDelete(
                index: index, widget: widget, localStorage: localStorage)) {
              setState(() {
                channelListController.updateList(localStorage, widget);
              });
            }
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(widget.channels?[index]['name'] ?? Fallbacks.nothingFound),
              ),
              isPlaying
                  ? _buildIconButton(
                      isStopFeature: true,
                      index: index,
                      icon: Icons.stop,
                      isStop: false,
                    )
                  : _buildIconButton(
                      isStopFeature: false,
                      index: index,
                      icon: Icons.play_circle,
                      isStop: true,
                    ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.info,
              color: AppColors.secondary,
            ),
            onPressed: () =>
                context.goNamed(AppRoutes.programs.name, extra: widget.channels?[index]['id']),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 8),
    );
  }

  Widget _buildIconButton({
    bool? isStopFeature,
    required int index,
    required IconData icon,
    bool? isStop,
  }) {
    bool isStopFeatureNotNull = isStopFeature != null;
    return IconButton(
      onPressed: () {
        if (isStopFeatureNotNull && isStopFeature == true) {
          player.stop();
        } else if (isStopFeatureNotNull && isStopFeature == false) {
          channelListController.playAudio(
            widget.channels?[index]['liveaudio']['url'],
            player,
          );
        }
        setState(() => isPlaying = isStop!);
      },
      icon: Icon(
        icon,
        color: AppColors.secondary,
      ),
    );
  }
}
