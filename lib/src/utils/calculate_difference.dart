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
