import 'package:intl/intl.dart';


///Format: ` Jan 10 2000`
String dateFormatter(DateTime originalDateTime) {
  return DateFormat('MMM d y').format(originalDateTime);
}


///Format: `1:30 PM`
String timeFormatter(DateTime originalDateTime, {bool isIn24Hours = false}) {
  return DateFormat(isIn24Hours ? 'HH:mm' : 'h:mm a').format(originalDateTime);
}