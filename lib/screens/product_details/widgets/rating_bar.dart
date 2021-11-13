import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int rating;
  final Function(int) onRatingSelected;

  RatingBar({this.rating, this.onRatingSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onRatingSelected(1),
          child: Icon(rating > 0 ? Icons.star : Icons.star_border, color: rating > 0 ? AppColors.red : AppColors.midGrey, size: 30),
        ),
        SizedBox(width: 3),
        GestureDetector(
          onTap: () => onRatingSelected(2),
          child: Icon(rating > 1 ? Icons.star : Icons.star_border, color: rating > 1 ? AppColors.red : AppColors.midGrey, size: 30),
        ),
        SizedBox(width: 3),
        GestureDetector(
          onTap: () => onRatingSelected(3),
          child: Icon(rating > 2 ? Icons.star : Icons.star_border, color: rating > 2 ? AppColors.red : AppColors.midGrey, size: 30),
        ),
        SizedBox(width: 3),
        GestureDetector(
          onTap: () => onRatingSelected(4),
          child: Icon(rating > 3 ? Icons.star : Icons.star_border, color: rating > 3 ? AppColors.red : AppColors.midGrey, size: 30),
        ),
        SizedBox(width: 3),
        GestureDetector(
          onTap: () => onRatingSelected(5),
          child: Icon(rating > 4 ? Icons.star : Icons.star_border, color: rating > 4 ? AppColors.red : AppColors.midGrey, size: 30),
        ),
      ],
    );
  }
}
