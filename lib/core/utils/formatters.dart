import 'package:intl/intl.dart';

class AppFormatters {
  static String currency(num value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  static String date(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  static String dayName(DateTime date) {
    return DateFormat('EEEE', 'id_ID').format(date);
  }

  static String gradePoint(double gpa) {
    return gpa.toStringAsFixed(2);
  }
}
