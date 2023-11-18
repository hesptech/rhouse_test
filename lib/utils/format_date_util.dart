import 'package:intl/intl.dart';

class FormatDateUtil {
  static String convertDatetimeToStrin(DateTime value ) {
    try {
      final DateFormat formatter = DateFormat('yyyy/MM/dd');
      final String formatted = formatter.format(value);
      return formatted;
    } catch (_) {
      return "";
    }
  }
}
