import 'package:flutter/material.dart';
import 'package:radio_guide/src/constants/app_colors.dart';
import 'package:radio_guide/src/constants/fallbacks.dart';
import 'package:radio_guide/src/features/channel_list/data/sr_api_services.dart';
import 'package:radio_guide/src/common_widgets/circular_progress_widget.dart';
import 'package:radio_guide/src/common_widgets/floating_action_buttons.dart';

class ListOfProgramsScreen extends StatefulWidget {
  const ListOfProgramsScreen({super.key, required this.channel});
  final int channel;

  @override
  State<ListOfProgramsScreen> createState() => _ListOfProgramsScreenState();
}

class _ListOfProgramsScreenState extends State<ListOfProgramsScreen> {
  List<dynamic>? programs = [];
  ApiServices apiController = ApiServices();
  bool _isLoading = true;

  @override
  void initState() {
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchNextDayAndCombine();
      }
    });
    super.initState();
  }

  void fetchNextDayAndCombine() async {
    List<dynamic>? listNextDay =
        await apiController.fetchNextDayPrograms(widget.channel);
    setState(() {
      programs = [...?programs, ...?listNextDay];
    });
  }

  void fetchData() async {
    setState(() => _isLoading = true);
    List<dynamic>? list = await apiController.fetchPrograms(widget.channel);
    setState(() {
      programs = list;
      _isLoading = false;
    });
  }

  String? extractTime(String timeStamp) {
    final RegExp regex = RegExp(r'\d+');
    final match = regex.firstMatch(timeStamp);

    if (match != null) {
      final numberString = match.group(0);
      final number = int.tryParse(numberString!);

      if (number != null) {
        final dateTime =
            DateTime.fromMillisecondsSinceEpoch(number, isUtc: true);

        return '${dateTime.toLocal().hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      }
    }
    return null;
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tablå",
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
          ? const CircularProgressWidget()
          : ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: programs!.length,
              itemBuilder: (BuildContext contect, int index) {
                return ListTile(
                  leading: Image.network(
                      programs?[index]['imageurl'] ?? Fallbacks.fallbackImage),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(programs?[index]['title'] ?? Fallbacks.nothingFound),
                      _buildTotalTimeText(
                          index: index,
                          end: 'endtimeutc',
                          start: 'starttimeutc')
                    ],
                  ),
                  trailing:
                      _buildTimeText(index: index, startOrEnd: 'starttimeutc'),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 8),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFABRow(context: context),
    );
  }

  Widget _buildTotalTimeText({
    required int index,
    required String start,
    required String end,
  }) {
    String totalTime = calculateDifference(
        start: extractTime(programs?[index]['starttimeutc'])
            .toString()
            .replaceAll(RegExp(r'[\[\]]'), ''),
        end: extractTime(programs?[index]['endtimeutc'])
            .toString()
            .replaceAll(RegExp(r'[\[\]]'), ''));
    return Text(
      totalTime,
      style: const TextStyle(color: AppColors.secondary),
    );
  }

  Widget _buildTimeText({required int index, required String startOrEnd}) {
    return Text(
      [extractTime(programs?[index][startOrEnd])]
          .toString()
          .replaceAll(RegExp(r'[\[\]]'), ''),
    );
  }
}

String calculateDifference({required String? start, required String? end}) {
  String? startTime = start;
  String? endTime = end;

  Duration startDuration = parseTime(startTime!);
  Duration endDuration = parseTime(endTime!);

  Duration difference = endDuration - startDuration;

  String differenceString = formatDuration(difference);

  return differenceString;
}

Duration parseTime(String timeStr) {
  List<int> parts = timeStr.split(':').map(int.parse).toList();
  return Duration(hours: parts[0], minutes: parts[1]);
}

String formatDuration(Duration duration) {
  if (duration.inMinutes == 0) {
    return "0 minuter";
  }

  String hours = duration.inHours > 0 ? '${duration.inHours} timmar ' : '';
  String minutes = duration.inMinutes.remainder(60) > 0
      ? '${duration.inMinutes.remainder(60)} minuter'
      : '';

  return '$hours$minutes';
}
