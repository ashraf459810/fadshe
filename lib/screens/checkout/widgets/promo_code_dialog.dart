import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/screens/checkout/widgets/promo_code_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PromoCodeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PromoCodeProvider promoCodeProvider = Provider.of(context);
    return Dialog(
      shape: AppShapes.roundedRectShape(),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spacingXXLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('promo_code'.tr(), style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: AppDimens.spacingSmall),
            CustomTextField(
              controller: promoCodeProvider.codeController,
              autoFocus: true,
              borderColor: AppColors.blueGrey,
              showBorder: true,
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: AppDimens.spacingXSmall),
            if (promoCodeProvider.message != null)
              Text(
                promoCodeProvider.message,
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.errorColor),
              ),
            SizedBox(height: AppDimens.spacingXLarge),
            if (!promoCodeProvider.loading)
              FlatButton(
                minWidth: 200,
                onPressed: () => promoCodeProvider.checkPromoCode(),
                padding: EdgeInsets.all(AppDimens.spacingSmall),
                shape: AppShapes.roundedRectShape(),
                color: AppColors.grey,
                child:
                    Text('check_code'.tr(), style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white)),
              ),
            if (promoCodeProvider.loading) SpinKitThreeBounce(size: 25, color: AppColors.grey.withOpacity(0.4))
          ],
        ),
      ),
    );
  }
}
