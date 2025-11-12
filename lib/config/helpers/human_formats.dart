import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadbleNumber(double number) {
    final formatterNumber = NumberFormat.compact(locale: 'en').format(number);
    return formatterNumber;
  }
}
