import 'package:intl/intl.dart';

/// Clean date formatting utilities for transactions and timeline displays.
abstract final class DateFormatter {
  static final _shortDate = DateFormat('MMM d, yyyy');
  static final _dayMonth = DateFormat('MMM d');
  static final _time = DateFormat('h:mm a');
  static final _fullDateTime = DateFormat('MMM d, yyyy · h:mm a');

  static String shortDate(DateTime date) => _shortDate.format(date);
  static String dayMonth(DateTime date) => _dayMonth.format(date);
  static String time(DateTime date) => _time.format(date);
  static String fullDateTime(DateTime date) => _fullDateTime.format(date);

  static String relativeDay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    final diff = target.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == -1) return 'Yesterday';
    if (diff == 1) return 'Tomorrow';
    return _shortDate.format(date);
  }
}
