import 'package:fad_shee/widgets/custom_dropdown.dart';
import 'package:flutter/foundation.dart';

class Category implements Option {
  final int id;
  final int parentId;
  final String title;
  final String imageUrl;
  final itemsCount;
  bool hasChildren;

  Category({
    @required this.id,
    @required this.parentId,
    @required this.title,
    this.imageUrl,
    this.itemsCount,
    this.hasChildren,
  });

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      id: jsonData['id'],
      parentId: jsonData['parent_id'],
      title: jsonData['title'],
      imageUrl: jsonData['image'],
      itemsCount: jsonData['items_count'] ?? 0,
    );
  }

  @override
  int get optionId => id;

  @override
  String get optionName => title;
}
