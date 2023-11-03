import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiServices {
  Dio dio = Dio();

  // Fetches the tablå of a specified channel.
  Future<List<dynamic>?> fetchPrograms(int channelID) async {
    try {
      List<dynamic>? allPrograms = [];

      for (int page = 1; page <= 10; page++) {
        final response = await dio.get(
            'https://api.sr.se/v2/scheduledepisodes?channelid=$channelID&format=json&page=$page');
        if (response.statusCode == 200) {
          if (response.data['schedule'] is List) {
            allPrograms.addAll(response.data['schedule']);
          }
        } else {
          if (kDebugMode) {
            print('Request for page $page failed with status: ${response.statusCode}');
          }
        }
      }
      return allPrograms;
    } catch (error) {
      if (kDebugMode) print('Error: $error');
    }
    return null;
  }

  // Fetch all the channels.
  Future<List<dynamic>?> fetchChannels() async {
    try {
      List<dynamic>? allChannels = [];
      for (int page = 1; page <= 6; page++) {
        final response = await dio.get('https://api.sr.se/api/v2/channels?format=json&page=$page');
        if (response.statusCode == 200) {
          if (response.data['channels'] is List) {
            allChannels.addAll(response.data['channels']);
          }
        } else {
          if (kDebugMode) {
            print('Request failed with status: ${response.statusCode}');
          }
        }
      }
      return allChannels;
    } catch (error) {
      if (kDebugMode) print('Error: $error');
    }
    return null;
  }
}
