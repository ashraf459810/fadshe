import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/extensions/datetime_extensions.dart';
import 'package:fad_shee/models/data/comment.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';

class CommentsListItem extends StatelessWidget {
  final Comment comment;

  CommentsListItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingSmall),
      child: Row(
        children: [
          comment.user.imageUrl != null
              ? CachedNetworkImage(imageUrl: comment.user.imageUrl, width: 60)
              : Icon(Icons.person, size: 60, color: AppColors.midGrey),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.user.name,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  comment.date.toDateFormat(),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.grey),
                ),
                SizedBox(height: 6),
                Text(comment.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
