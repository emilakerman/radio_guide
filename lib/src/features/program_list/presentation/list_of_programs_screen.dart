import 'package:flutter/material.dart';
import 'package:radio_guide/src/constants/app_colors.dart';
import 'package:radio_guide/src/constants/fallbacks.dart';
import 'package:radio_guide/src/features/channel_list/data/sr_api_services.dart';
import 'package:radio_guide/src/common_widgets/circular_progress_widget.dart';
import 'package:radio_guide/src/common_widgets/floating_action_buttons.dart';
import 'package:radio_guide/src/utils/calculate_difference.dart';
import 'package:radio_guide/src/utils/extract_time.dart';

class ListOfProgramsScreen extends StatefulWidget {
  const ListOfProgramsScreen({super.key, required this.channel});
  final int channel;

  @override
  State<ListOfProgramsScreen> createState() => _ListOfProgramsScreenState();
}

class _ListOfProgramsScreenState extends State<ListOfProgramsScreen> {
  List<dynamic>? programs = [];
  SrAPIRepository apiController = SrAPIRepository();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchNextDayAndCombine();
      }
    });
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

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tablå",
        ),
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
      [
        extractTime(
          programs?[index][startOrEnd],
        ),
      ].toString().replaceAll(RegExp(r'[\[\]]'), ''),
    );
  }
}
