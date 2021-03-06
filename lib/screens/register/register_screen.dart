import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/cities_model.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/register/Dropdown.dart';
import 'package:fad_shee/screens/register/register_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/custom_text_field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseScreenState<RegisterScreen> {
  RegisterProvider provider;
  StreamSubscription subscription;
  String city;
  int cityid;
  List<City> cities = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log("hereeeeee");
      subscription = Provider.of<UserProvider>(context, listen: false)
          .message
          .stream
          .listen((event) {
        log("here from register");
        Fluttertoast.showToast(
            msg: event,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.red,
            fontSize: 16.0);

        Flushbar(message: event, duration: Duration(seconds: 3))..show(context);
      });
    });

    super.initState();
  }

  @override
  onBuildStart() {
    provider = Provider.of<RegisterProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(
        context: context,
        titleText: 'register'.tr(),
      );

  @override
  Widget buildState(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider()..getallcities(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints builderConstraints) =>
              ScrollConfiguration(
            behavior: ScrollBehavior()
              ..buildViewportChrome(context, null, AxisDirection.down),
            child: KeyboardActions(
              config: provider.keyboardActionsConfig,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                      minHeight: builderConstraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: provider.formKey,
                      child: Container(
                        padding: EdgeInsets.all(AppDimens.spacingXXXLarge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Spacer(flex: 1),
                            Text('welcome_to_join_our_community'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(fontWeight: FontWeight.w900)),
                            SizedBox(height: AppDimens.spacingXXXLarge),
                            CustomTextField(
                              backingFieldMap: provider.formData,
                              backingFieldName: 'name',
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              keyboardType: TextInputType.text,
                              isRequired: true,
                              focusNode: provider.focusNodes[0],
                              nextFocusNode: provider.focusNodes[1],
                              textInputAction: TextInputAction.next,
                              showBorder: true,
                              label: 'full_name'.tr().toUpperCase(),
                            ),
                            SizedBox(height: AppDimens.spacingMedium),
                            CustomTextField(
                              backingFieldMap: provider.formData,
                              backingFieldName: 'email',
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              keyboardType: TextInputType.text,
                              isRequired: true,
                              focusNode: provider.focusNodes[1],
                              nextFocusNode: provider.focusNodes[2],
                              textInputAction: TextInputAction.next,
                              showBorder: true,
                              label: 'email'.tr().toUpperCase(),
                            ),
                            SizedBox(height: AppDimens.spacingMedium),
                            CustomTextField(
                              backingFieldMap: provider.formData,
                              backingFieldName: 'phone',
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              keyboardType: TextInputType.text,
                              isRequired: true,
                              focusNode: provider.focusNodes[2],
                              nextFocusNode: provider.focusNodes[3],
                              textInputAction: TextInputAction.next,
                              showBorder: true,
                              label: 'phone'.tr().toUpperCase(),
                            ),
                            SizedBox(height: AppDimens.spacingMedium),
                            CustomTextField(
                              backingFieldMap: provider.formData,
                              backingFieldName: 'password',
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              keyboardType: TextInputType.text,
                              isRequired: true,
                              obscureText: true,
                              focusNode: provider.focusNodes[3],
                              textInputAction: TextInputAction.go,
                              showBorder: true,
                              label: 'password'.tr().toUpperCase(),
                            ),
                            SizedBox(height: AppDimens.spacingMedium),
                            CustomTextField(
                              backingFieldMap: provider.formData,
                              backingFieldName: 'refferal_id',
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              keyboardType: TextInputType.number,
                              isRequired: false,
                              // focusNode: provider.focusNodes[1],
                              // nextFocusNode: provider.focusNodes[2],
                              textInputAction: TextInputAction.next,
                              showBorder: true,
                              label: 'Referral ID'.tr().toUpperCase(),
                            ),
                            SizedBox(height: AppDimens.spacingMedium),
                            Container(
                              height: 44,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: AppColors.midGrey,
                                  )),
                              child: DropDown(
                                hint: "select city".tr(),
                                chosenvalue: city,
                                list: Provider.of<UserProvider>(context)
                                    .getcities,
                                onchanged: (val) {
                                  city = val.title;
                                  cityid = val.id;
                                  provider.formData["cities_id"] =
                                      val.id.toString();
                                  log(provider.formData["cities_id"]);
                                },
                                getindex: () {},
                              ),
                            ),
                            SizedBox(height: AppDimens.spacingLarge),
                            Spacer(flex: 2),
                            Provider.of<UserProvider>(context).loading
                                ? SpinKitThreeBounce(
                                    color: AppColors.grey.withOpacity(0.3),
                                    size: 35)
                                : registerButton(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton(BuildContext context) => FlatButton(
        onPressed: () async {
          bool isValid = provider.validateAndSaveFromData() && cityid != null;
          if (isValid) {
            final result =
                await Provider.of<UserProvider>(context, listen: false)
                    .register(provider.formData);

            if (!result.isSuccessful) {
              Fluttertoast.showToast(
                  msg: result.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.red,
                  fontSize: 16.0);
            }
          }
        },
        shape: AppShapes.roundedRectShape(),
        padding: EdgeInsets.symmetric(vertical: AppDimens.spacingLarge),
        color: AppColors.red,
        child: Text('register'.tr().toUpperCase(),
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
