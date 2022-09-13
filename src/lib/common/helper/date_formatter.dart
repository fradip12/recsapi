import 'package:intl/intl.dart';

class CustomDateFormat {
  CustomDateFormat._();
  static DateFormat dateDD = DateFormat('dd');
  static DateFormat dateMM = DateFormat('MM');
  static DateFormat dateYY = DateFormat('yyyy');
  static DateFormat dateHMS = DateFormat('HH:mm:ss');
  static DateFormat dateYMD = DateFormat('yyyy-MM-dd');
  static DateFormat dateDMY = DateFormat('dd MMMM yyyy');
  static DateFormat dateEDMY = DateFormat('EEEE,dd MMMM yyyy');
  static DateFormat dateDMYHMS = DateFormat('dd MMM yyyy HH:mm:ss');
}
