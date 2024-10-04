import 'package:intl/intl.dart';

String formatDate(DateTime date,
    [String? newPattern = "dd MMMM yyyy", String? locale = "en_US"]) {
  final DateFormat formatter = DateFormat(newPattern);
  final String formatted = formatter.format(date);
  return formatted;
}

String formatNumber(double value) {
  final formatter = NumberFormat.decimalPattern().format(value);
  return formatter;
}
