String? extractTime(String timeStamp) {
  final RegExp regex = RegExp(r'\d+');
  final match = regex.firstMatch(timeStamp);

  if (match != null) {
    final numberString = match.group(0);
    final number = int.tryParse(numberString!);

    if (number != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(number, isUtc: true);

      return '${dateTime.toLocal().hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
  return null;
}
