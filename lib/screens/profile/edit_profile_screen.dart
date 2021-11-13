import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/custom_text_field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit_profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends BaseScreenState<EditProfileScreen> {
  UserProvider provider;
  bool _isInit = true;
  StreamSubscription messageSubscription;

  @override
  onBuildStart() {
    provider = Provider.of<UserProvider>(context);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      messageSubscription = Provider.of<UserProvider>(context).message.stream.listen((event) {
        Flushbar(message: event, duration: Duration(seconds: 3))..show(context);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(context: context, titleText: 'edit_profile'.tr());

  @override
  Widget buildState(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingXXLarge, vertical: AppDimens.spacingXXLarge),
                decoration: AppShapes.roundedRectDecoration(),
                child: Form(
                  key: provider.editProfileFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userImage(),
                      textField('full_name'.tr(), provider.userMap['name'], TextInputType.text, 'name'),
                      textField('mobile'.tr(), provider.userMap['phone'], TextInputType.phone, 'phone'),
                      textField('address'.tr(), provider.userMap['address'], TextInputType.text, 'address'),
                      //addressList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        provider.loading ? SpinKitThreeBounce(color: AppColors.lightGrey, size: 35) : saveButton()
      ],
    );
  }

  userImage() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: AppDimens.spacingXLarge),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.lightGrey,
          child: provider.user.imageUrl == null
              ? CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/app_logo.png'),
                )
              : CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  backgroundImage: CachedNetworkImageProvider(provider.userMap['images']),
                ),
        ),
      );

  textField(label, text, keyboardType, backingFieldName) => Padding(
        padding: const EdgeInsets.only(bottom: AppDimens.spacingMedium),
        child: CustomTextField(
          text: text,
          showBorder: true,
          borderColor: AppColors.midGrey,
          label: label,
          isRequired: true,
          backingFieldMap: provider.userMap,
          backingFieldName: backingFieldName,
          padding: EdgeInsets.all(AppDimens.spacingMedium),
          textStyle: Theme.of(context).textTheme.bodyText2,
          keyboardType: keyboardType,
        ),
      );

  saveButton() => Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.all(AppDimens.spacingLarge),
        child: RaisedButton(
          onPressed: provider.updateUserInfo,
          shape: AppShapes.roundedRectShape(),
          color: AppColors.red,
          child: Text('save_changes'.tr().toUpperCase(),
              style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white)),
        ),
      );

  @override
  void dispose() {
    messageSubscription.cancel();
    super.dispose();
  }
}
