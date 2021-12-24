import 'package:intl/intl.dart';

class DateFormatter {
  final DateFormat _timeFormat = DateFormat("HH:mm");

  String formatDates(DateTime startDate, DateTime endDate) {
    var localStart = startDate.toLocal();
    var localEnd = endDate.toLocal();
    if (localStart.day == localEnd.day &&
        localStart.month == localEnd.month &&
        localStart.year == localEnd.year) {
      return "${_formatSingleDateTime(localStart)} - ${_timeFormat.format(localEnd)}";
    } else {
      return "${_formatSingleDateTime(localStart)} - ${_formatSingleDateTime(
          localEnd)}";
    }
  }

  String _formatSingleDateTime(DateTime localDateTime) {
    return DateFormat("dd.MM.yyyy HH:mm").format(localDateTime);
  }

  String formatTimes(DateTime startDate, DateTime endDate) {
    var localStart = _timeFormat.format(startDate.toLocal());
    var localEnd = _timeFormat.format(endDate.toLocal());

    return "$localStart - $localEnd";
  }
}