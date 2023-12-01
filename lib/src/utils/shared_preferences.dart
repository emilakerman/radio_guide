import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocallyStoredData {
  final String key = 'channels';

  void saveData({required Map<String, dynamic> channel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> savedChannels = prefs.getStringList(key) ?? [];

    savedChannels.add(jsonEncode(channel));
    await prefs.setStringList(key, savedChannels);
  }

  Future<List<dynamic>> readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedChannels = prefs.getStringList(key) ?? [];

    List<Map<String, dynamic>> channels = savedChannels
        .map((channel) => jsonDecode(channel) as Map<String, dynamic>)
        .toList();

    return channels;
  }

  Future<void> deleteData({required Map<String, dynamic> channel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedChannels = prefs.getStringList(key) ?? [];

    String channelJson = jsonEncode(channel);

    savedChannels.removeWhere((savedChannel) {
      return savedChannel == channelJson;
    });

    await prefs.setStringList(key, savedChannels);
  }
}
