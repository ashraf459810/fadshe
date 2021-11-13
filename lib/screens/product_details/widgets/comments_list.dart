import 'package:fad_shee/models/data/comment.dart';
import 'package:fad_shee/screens/product_details/widgets/comments_list_item.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  final List<Comment> comments;

  CommentsList(this.comments);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (ctx, index) => CommentsListItem(comments[index]),
    );
  }
}
