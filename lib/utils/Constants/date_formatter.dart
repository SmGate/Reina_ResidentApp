import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  // Parse the date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Format the DateTime object into the desired format
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(dateTime);

  return formattedDate;
}
