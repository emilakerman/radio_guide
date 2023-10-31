import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_guide/constants/app_colors.dart';
import 'package:radio_guide/routing/app_routes.dart';
import 'package:radio_guide/sr_api_services.dart';
import 'package:audioplayers/audioplayers.dart';

class ListOfChannelsScreen extends StatefulWidget {
  const ListOfChannelsScreen({super.key});

  @override
  State<ListOfChannelsScreen> createState() => _ListOfChannelsScreenState();
}

class _ListOfChannelsScreenState extends State<ListOfChannelsScreen> {
  List<dynamic>? channels = [];
  ApiController apiController = ApiController();
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
        backgroundColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        leading: const BackButton(
          color: AppColors.secondary,
        ),
      ),
      backgroundColor: AppColors.primary,
      body: ListView.separated(
        itemCount: channels!.length,
        itemBuilder: (BuildContext contect, int index) {
          return ListTile(
            leading: Image.network(channels?[index]['image']),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(channels?[index]['name'] ?? "Nothing found"),
                isPlaying
                    ? IconButton(
                        onPressed: () {
                          player.stop();
                          setState(() => isPlaying = false);
                        },
                        icon: const Icon(
                          Icons.stop,
                          color: AppColors.secondary,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() => isPlaying = true);
                          playAudio(channels?[index]['liveaudio']['url']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.additional,
                        ),
                        icon: const Icon(
                          Icons.play_circle,
                          color: AppColors.secondary,
                        ),
                      ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.info,
                color: AppColors.secondary,
              ),
              onPressed: () =>
                  context.goNamed(AppRoutes.programs.name, extra: channels?[index]['id']),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 8),
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
      onPressed: () {},
      backgroundColor: AppColors.secondary,
      child: Icon(icon),
    );
  }
}
