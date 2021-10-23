import 'package:intl/intl.dart';

class DateFormatter {
  String formatDates(DateTime startDate, DateTime endDate) {
    var localStart = startDate.toLocal();
    var localEnd = endDate.toLocal();
    if (localStart.day == localEnd.day &&
        localStart.month == localEnd.month &&
        localStart.year == localEnd.year) {
      return "${_formatSingleDateTime(localStart)} - ${DateFormat("HH:mm")
          .format(localEnd)}";
    } else {
      return "${_formatSingleDateTime(localStart)} - ${_formatSingleDateTime(
          localEnd)}";
    }
  }

  String _formatSingleDateTime(DateTime localDateTime) {
    return DateFormat("dd.MM.yyyy HH:mm").format(localDateTime);
  }
}