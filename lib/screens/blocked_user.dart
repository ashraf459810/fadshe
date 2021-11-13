import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlockedUserScreen extends StatelessWidget {
  static const routeName = 'blocked_user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: double.infinity),
            Spacer(),
            Image.asset('assets/images/ic_blocked_user.png', color: AppColors.midGrey, width: 125, height: 125),
            SizedBox(
              height: AppDimens.spacingMedium,
            ),
            Text(
              'Sorry!',
              style: Theme.of(context).textTheme.headline1.copyWith(color: AppColors.grey),
            ),
            SizedBox(height: AppDimens.spacingSmall),
            Text(
              'Your Account has been suspended',
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.grey),
            ),
            Spacer(),
            FlatButton(
              minWidth: double.infinity,
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingXLarge, vertical: AppDimens.spacingSmall),
              onPressed: () => SystemNavigator.pop(),
              shape: AppShapes.fullyRoundedRectShape(),
              color: AppColors.grey,
              child: Text('Close App', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
