import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/language.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class LanguagesListItem extends StatelessWidget {
  final Language language;

  LanguagesListItem(this.language);

  @override
  Widget build(BuildContext context) {
    bool isCurrentLanguage = context.locale.languageCode == language.code;
    return GestureDetector(
      onTap: () {
        context.locale = Locale(language.code);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingLarge, horizontal: AppDimens.spacingXLarge),
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(AppDimens.spacingXSmall),
                alignment: Alignment.center,
                decoration:
                    AppShapes.roundedRectDecoration(radius: AppDimens.spacingXSmall, borderColor: AppColors.midGrey),
                child: Text(language.code.toUpperCase(),
                    style: Theme.of(context).textTheme.button.copyWith(color: AppColors.grey)),
              ),
            ),
            SizedBox(width: AppDimens.spacingXXLarge),
            Expanded(
              flex: 6,
              child: Text(language.name, style: Theme.of(context).textTheme.button.copyWith(color: Colors.black)),
            ),
            if (isCurrentLanguage)
              Container(width: 10, height: 10, decoration: AppShapes.circleDecoration(color: Colors.green))
          ],
        ),
      ),
    );
  }
}
