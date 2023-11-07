import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/constants/fallbacks.dart';
import 'package:radio_guide/controllers/channel_list_controller.dart';
import 'package:radio_guide/routing/app_routes.dart';
import 'package:radio_guide/shared_preferences.dart';
import 'package:radio_guide/widgets/global_snackbar.dart';

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
    bool isOnChannelPage =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath == '/channels';
    return ListView.separated(
      itemCount: widget.channels!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(widget.channels?[index]['image'] ?? Fallbacks.fallbackImage),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(widget.channels?[index]['name'] ?? Fallbacks.nothingFound),
              ),
              Consumer(
                builder: (context, ref, child) => _buildIconButton(
                  index: index,
                  icon: Icons.play_circle,
                  url: widget.channels?[index]['liveaudio']['url'],
                  ref: ref,
                  onPressed: () {
                    if (isPlaying) {
                      ref.read(currentURLProvider.notifier).state = "";
                      player.stop();
                    } else {
                      channelListController.playAudio(
                        widget.channels?[index]['liveaudio']['url'],
                        player,
                      );
                      ref.read(currentURLProvider.notifier).state =
                          widget.channels?[index]['liveaudio']['url'];
                    }
                    setState(() => isPlaying = !isPlaying);
                  },
                ),
              ),
              _buildIconButton(
                index: index,
                icon: isOnChannelPage ? Icons.favorite : Icons.favorite_border_sharp,
                onPressed: () {
                  GlobalSnackBar.show(context, isOnChannelPage);
                  if (channelListController.saveOrDelete(
                      index: index, widget: widget, localStorage: localStorage)) {
                    setState(() {
                      channelListController.updateList(localStorage, widget);
                    });
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.info,
                  color: AppColors.secondary,
                ),
                onPressed: () =>
                    context.goNamed(AppRoutes.programs.name, extra: widget.channels?[index]['id']),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 8),
    );
  }

  Widget _buildIconButton({
    required int index,
    required Function() onPressed,
    required IconData icon,
    String? url,
    WidgetRef? ref,
  }) {
    if (ref != null) {
      if (url == ref.watch(currentURLProvider.notifier).state) {
        icon = Icons.stop;
      }
    }
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.secondary,
      ),
    );
  }
}
