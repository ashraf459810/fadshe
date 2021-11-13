import 'package:fad_shee/widgets/custom_dropdown.dart';

class Value implements Option {
  final int id;
  final String name;

  Value({this.id, this.name});

  factory Value.fromJson(Map<String, dynamic> jsonData) {
    return Value(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }

  @override
  int get optionId => id;

  @override
  String get optionName => name;
}
