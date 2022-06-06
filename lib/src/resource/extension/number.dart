import 'package:intl/intl.dart';

extension VnCurrence on double {
  String get getVnCurrence =>
      NumberFormat.simpleCurrency(locale: 'vi').format(this);
}
