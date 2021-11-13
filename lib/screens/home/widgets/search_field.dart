import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/screens/search/search_screen.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(SearchScreen.routeName),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppDimens.spacingMedium, horizontal: AppDimens.pagePadding),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingMedium, horizontal: AppDimens.spacingLarge),
        decoration: AppShapes.fullyRoundedRectDecoration(color: Colors.white),
        child: Row(
          children: [
            Icon(Icons.search, size: 24, color: Colors.grey[300]),
            SizedBox(width: AppDimens.spacingSmall),
            Text('type_your_search_keyword'.tr(), style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey[400])),
          ],
        ),
      ),
    );
  }
}
