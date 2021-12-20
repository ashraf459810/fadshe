import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/enum/list_item_location.dart';
import 'package:fad_shee/models/ui/account_item_model.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {
  final AccountItemModel item;
  final ListItemLocation location;

  AccountListItem({@required this.item, this.location});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => item.onClickNavigateTo != null
          ? navService.pushNamed(item.onClickNavigateTo)
          : item.onClick(),
      splashColor: AppColors.grey.withOpacity(0.1),
      borderRadius: location == ListItemLocation.first
          ? BorderRadius.only(
              topLeft: Radius.circular(AppDimens.borderRadiusLarge),
              topRight: Radius.circular(AppDimens.borderRadiusLarge))
          : location == ListItemLocation.last
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(AppDimens.borderRadiusLarge),
                  bottomRight: Radius.circular(AppDimens.borderRadiusLarge))
              : BorderRadius.zero,
      child: Ink(
        decoration: AppShapes.roundedRectDecoration(),
        child: Container(
          padding: EdgeInsets.all(AppDimens.spacingXLarge),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/${item.icon}',
                  width: AppDimens.iconSizeLarge,
                  color:
                      item.iconColor != null ? item.iconColor : AppColors.red),
              SizedBox(width: AppDimens.spacingMedium),
              Expanded(
                  child: Text(item.title,
                      style: Theme.of(context).textTheme.button)),
              if (item.showArrow)
                Icon(
                    context.locale.languageCode == 'en'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: AppColors.midGrey),
            ],
          ),
        ),
      ),
    );
  }
}
