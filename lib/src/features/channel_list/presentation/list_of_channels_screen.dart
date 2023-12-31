import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_guide/src/constants/app_colors.dart';
import 'package:radio_guide/src/features/channel_list/presentation/channel_list_controller.dart';
import 'package:radio_guide/src/features/channel_list/data/sr_api_services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:radio_guide/src/common_widgets/channel_list.dart';
import 'package:radio_guide/src/common_widgets/circular_progress_widget.dart';
import 'package:radio_guide/src/common_widgets/floating_action_buttons.dart';

class ListOfChannelsScreen extends StatefulWidget {
  const ListOfChannelsScreen({super.key});

  @override
  State<ListOfChannelsScreen> createState() => _ListOfChannelsScreenState();
}

class _ListOfChannelsScreenState extends State<ListOfChannelsScreen> {
  List<dynamic>? channels = [];
  SrAPIRepository apiController = SrAPIRepository();
  TextEditingController editingController = TextEditingController();

  late AudioPlayer player;
  bool isPlaying = false;
  bool _isLoading = true;
  bool showSearchBar = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    fetchData();
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

  void filterSearchResults(String query) async {
    List<dynamic>? duplicateItems = await apiController.fetchChannels();
    setState(() {
      channels = duplicateItems?.where((item) {
        if (item is Map<String, dynamic> && item.containsKey("name")) {
          return item["name"]
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase())
              ? true
              : false;
        }
        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (_, ref, __) => ref.watch(searchbarControllerProvider)
              ? _buildTextField()
              : const Text(
                  "Radiokanaler",
                ),
        ),
        leading: const BackButton(
          color: AppColors.secondary,
        ),
      ),
      backgroundColor: AppColors.primary,
      body: _isLoading
          ? const CircularProgressWidget()
          : ChannelList(
              channels: channels,
              isFavorite: false,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFABRow(context: context),
    );
  }

  Widget _buildTextField() {
    return TextField(
      onChanged: (String value) {
        filterSearchResults(value);
      },
      controller: editingController,
      decoration: const InputDecoration(
        labelText: "Sök här",
        suffixIcon: Icon(Icons.search),
        suffixIconColor: AppColors.secondary,
      ),
    );
  }
}
