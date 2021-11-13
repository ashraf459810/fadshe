import 'package:easy_localization/easy_localization.dart';

extension IntExtensions on DateTime {
  String toDateFormat() {
    return DateFormat('MMM dd, yyyy').format(this);
  }
}
