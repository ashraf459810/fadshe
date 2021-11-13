import 'package:fad_shee/widgets/custom_dropdown.dart';

class SortByOption implements Option {
  final int id;
  final String key;
  final String name;

  SortByOption(this.id, this.key, this.name);

  @override
  String get optionName => name;

  @override
  int get optionId => id;
}
