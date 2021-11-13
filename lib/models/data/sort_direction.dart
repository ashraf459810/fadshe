import 'package:fad_shee/widgets/custom_dropdown.dart';

class SortDirection implements Option {
  final int id;
  final String key;
  final String name;

  SortDirection(this.id, this.key, this.name);

  @override
  int get optionId => id;

  @override
  String get optionName => name;
}
