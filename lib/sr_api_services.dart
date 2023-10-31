import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiController {
  Dio dio = Dio();

  // Fetches the tablå of a specified channel.
  Future<List<dynamic>?> fetchPrograms(int channelID) async {
    try {
      final Dio dio = Dio();
      List<dynamic>? combinedData = [];

      for (int page = 1; page <= 10; page++) {
        final response = await dio.get(
            'https://api.sr.se/v2/scheduledepisodes?channelid=$channelID&format=json&page=$page');
        if (response.statusCode == 200) {
          if (response.data['schedule'] is List) {
            combinedData.addAll(response.data['schedule']);
          }
        } else {
          if (kDebugMode) {
            print('Request for page $page failed with status: ${response.statusCode}');
          }
        }
      }
      return combinedData;
    } catch (error) {
      if (kDebugMode) print('Error: $error');
    }
    return null;
  }

  // Fetch all the channels.
  Future<List<dynamic>?> fetchChannels() async {
    try {
      final response = await Dio().get('https://api.sr.se/api/v2/channels?format=json');
      if (response.statusCode == 200) {
        return response.data['channels'];
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) print('Error: $error');
    }
    return null;
  }
}
