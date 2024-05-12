import 'package:intl/intl.dart';

final formatNumber = NumberFormat('###,###,###');

String getNumberFormat(price) {
  return formatNumber.format(double.parse(price));
}
