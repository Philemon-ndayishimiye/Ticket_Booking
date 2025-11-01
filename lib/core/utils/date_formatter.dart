// Lightweight date formatter helpers
import 'package:intl/intl.dart';

String formatIsoDate(String isoString) {
  // Parse ISO 8601 string and return a readable format
  final date = DateTime.parse(isoString);
  return DateFormat.yMMMd().add_jm().format(date);
}
