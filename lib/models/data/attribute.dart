import 'value.dart';

class Attribute {
  final int id;
  final String name;
  final List<Value> values;

  Attribute({this.id, this.name, this.values});

  factory Attribute.fromJson(Map<String, dynamic> jsonData) {
    return Attribute(
      id: jsonData['id'],
      name: jsonData['name'],
      values: (jsonData['values'] as List).map((e) => Value.fromJson(e)).toList(),
    );
  }
}
