import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String address;
  final bool isActive;

  User({@required this.id, @required this.name, this.imageUrl, this.email, this.phone, this.address, this.isActive});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      name: jsonData['name'],
      imageUrl:
          jsonData['images'] != null ? 'http://fadshee.bitsblend.org/storage/user_images/${jsonData['images']}' : null,
      email: jsonData['email'],
      phone: jsonData['phone'],
      address: jsonData['address'],
      isActive: jsonData['active'] == 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'images': imageUrl?.substring(imageUrl.lastIndexOf('/') + 1),
        'phone': phone,
        'email': email,
        'address': address
      };

  Map<String, dynamic> toMap() =>
      {'id': id, 'name': name, 'images': imageUrl, 'phone': phone, 'email': email, 'address': address};
}
