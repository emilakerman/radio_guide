// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:radio_guide/shared_preferences.dart';
import 'package:radio_guide/widgets/channel_list.dart';
part 'channel_list_controller.g.dart';

@riverpod
class ChannelListController extends _$ChannelListController {
  // This is the saved string for the currently playing radio channel.
  @override
  String build() => "";

  void setCurrentURL(String url) {
    state = url;
  }

  void updateList(LocallyStoredData data, ChannelList widget) async {
    widget.channels = await data.readData();
  }

  void playAudio(String url, AudioPlayer player) async {
    player.stop();
    await player.play(UrlSource(url));
  }

  bool saveOrDelete({
    required int index,
    required ChannelList widget,
    required LocallyStoredData localStorage,
  }) {
    if (widget.isFavorite) {
      localStorage.deleteData(channel: widget.channels?[index]);
      return true;
    } else {
      localStorage.saveData(channel: widget.channels?[index]);
      return false;
    }
  }
}

@riverpod
class SearchbarController extends _$SearchbarController {
  @override
  bool build() => false;

  void reverseBool() => state = !state;
}

@riverpod
class SideButtonsController extends _$SideButtonsController {
  // false == 3 buttons not visible
  @override
  bool build() => false;

  void reverseBool() => state = !state;
}
