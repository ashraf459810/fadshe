import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/user.dart';

class Comment {
  final int id;
  final String text;
  final DateTime date;
  final User user;

  Comment({this.id, this.text, this.date, this.user});

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
      id: data['id'],
      text: data['comment'],
      date: DateFormat('yyyy-MM-ddTHH:mm:ss').parse(data['created_at'], true),
      user: User.fromJson(data['user']),
    );
  }
}
