import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';

import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/providers/user_provider.dart';

import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/login/login_provider.dart';
import 'package:fad_shee/screens/register/register_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/custom_text_field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreenState<LoginScreen> {
  LoginProvider provider;
  UserProvider userprovider;

  StreamSubscription subscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      subscription = Provider.of<UserProvider>(context, listen: false)
          .message
          .stream
          .listen((event) {
        Fluttertoast.showToast(
            msg: event,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        // Flushbar(message: event, duration: Duration(seconds: 3))..show(context);
      });
    });

    super.initState();
  }

  @override
  onBuildStart() {
    provider = Provider.of<LoginProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(
        context: context,
        titleText: 'login'.tr(),
      );

  @override
  Widget buildState(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints builderConstraints) =>
          SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              new BoxConstraints(minHeight: builderConstraints.maxHeight),
          child: IntrinsicHeight(
            child: Form(
              key: provider.formKey,
              child: Container(
                padding: EdgeInsets.all(AppDimens.spacingXXXLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(flex: 1),
                    Text('welcome_back'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontWeight: FontWeight.w900)),
                    SizedBox(height: AppDimens.spacingXXXLarge),
                    CustomTextField(
                      backingFieldMap: provider.formData,
                      backingFieldName: 'email',
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.emailAddress,
                      isRequired: true,
                      focusNode: provider.focusNodes[0],
                      nextFocusNode: provider.focusNodes[1],
                      textInputAction: TextInputAction.go,
                      showBorder: true,
                      label: 'email'.tr().toUpperCase(),
                    ),
                    SizedBox(height: AppDimens.spacingMedium),
                    CustomTextField(
                      backingFieldMap: provider.formData,
                      backingFieldName: 'password',
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.text,
                      isRequired: true,
                      obscureText: true,
                      focusNode: provider.focusNodes[1],
                      textInputAction: TextInputAction.go,
                      showBorder: true,
                      label: 'password'.tr().toUpperCase(),
                    ),
                    Spacer(flex: 2),
                    Provider.of<UserProvider>(context).loading
                        ? SpinKitThreeBounce(
                            color: AppColors.grey.withOpacity(0.3), size: 35)
                        : actions()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container separatorLine() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: AppDimens.spacingMedium),
        height: 1,
        color: Colors.grey[300]);
  }

  actions() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          loginButton(context),
          SizedBox(height: AppDimens.spacingSmall),
          newUserButton(context),
          separatorLine(),
          facebookButton(context),
          SizedBox(
            height: 10,
          ),
          appleSignIn(context),
        ],
      );

  Widget loginButton(BuildContext context) => FlatButton(
        onPressed: () async {
          bool isValid = provider.validateAndSaveFromData();
          if (isValid) {
            await Provider.of<UserProvider>(context, listen: false)
                .login(provider.formData);
          }
        },
        shape: AppShapes.roundedRectShape(),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingLarge),
        color: AppColors.red,
        child: Text('login'.tr().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white)),
      );

  Widget facebookButton(BuildContext context) => FlatButton.icon(
        onPressed: () => Provider.of<UserProvider>(context, listen: false)
            .loginWithFacebook(),
        shape: AppShapes.roundedRectShape(),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingLarge),
        color: AppColors.blue,
        icon: Image.asset('assets/images/ic_facebook.png',
            color: Colors.white, width: 20),
        label: Text('continue_with_facebook'.tr().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white)),
      );
  Widget appleSignIn(BuildContext context) => FlatButton.icon(
        onPressed: () async {
          Result result =
              await Provider.of<UserProvider>(context, listen: false)
                  .loginWithApple();
        },

        shape: AppShapes.roundedRectShape(),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingLarge),
        color: Colors.grey[50],
        icon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/apple.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: null /* add child content here */,
        ),
        // Container(
        //   child: Image.asset(
        //     'assets/images/apple.png',
        //     width: 25,
        //   ),
        // ),
        label: Text('continue_with_apple'.tr().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.black)),
      );

  Widget newUserButton(BuildContext context) => FlatButton(
        onPressed: () => navService.pushNamed(RegisterScreen.routeName),
        shape: AppShapes.roundedRectShape(),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingLarge),
        color: AppColors.grey,
        child: Text('create_an_account'.tr().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white)),
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
