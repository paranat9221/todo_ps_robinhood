import 'package:intl/intl.dart';

class CommonText {
  String dateText(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (dateTime == today) {
      return 'Today';
    } else if (dateTime == yesterday) {
      return 'Yesterday';
    } else if (dateTime == tomorrow) {
      return 'Tomorrow';
    }
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String dateTimeText(DateTime dateTime) {
    return DateFormat('dd MMM yyyy hh:mm').format(dateTime);
  }
}
