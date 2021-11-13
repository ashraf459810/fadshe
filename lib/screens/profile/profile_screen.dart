import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/profile/edit_profile_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseScreenState<ProfileScreen> {
  UserProvider userProvider;

  @override
  onBuildStart() {
    userProvider = Provider.of<UserProvider>(context);
  }

  Widget _buildUserImage() => Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 65,
              backgroundColor: AppColors.transparentLightGrey,
              child: userProvider.user.imageUrl == null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/app_logo.png'),
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                          userProvider.userMap['images']),
                    ),
            ),
          ],
        ),
      );

  Column _buildUserInfoColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('user_info'.tr(), style: Theme.of(context).textTheme.headline5),
          Container(height: 0.5, color: AppColors.midGrey),
          SizedBox(height: AppDimens.spacingMedium),
          _buildInfoRow(context, Icons.person, userProvider.userMap['name']),
        ],
      );

  Column _buildContactInfoColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('contact_info'.tr(),
              style: Theme.of(context).textTheme.headline5),
          Container(height: 0.5, color: AppColors.midGrey),
          SizedBox(height: AppDimens.spacingMedium),
          if (userProvider.userMap['phone'] != null)
            _buildInfoRow(
                context, Icons.phone_iphone, userProvider.userMap['phone']),
          if (userProvider.userMap['phone'] != null)
            SizedBox(height: AppDimens.spacingXSmall),
          _buildInfoRow(
              context, Icons.mail_outline, userProvider.userMap['email'])
        ],
      );

  Column _buildAddressesColumn(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('address'.tr(), style: Theme.of(context).textTheme.headline5),
          Container(height: 0.5, color: AppColors.midGrey),
          SizedBox(height: AppDimens.spacingMedium),
          _buildInfoRow(context, Icons.location_on_outlined,
              userProvider.userMap['address'])
        ],
      );

  Row _buildInfoRow(BuildContext context, IconData iconKey, String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconKey, size: AppDimens.iconSizeMedium, color: AppColors.grey),
          SizedBox(width: AppDimens.spacingMedium),
          Text(text, style: Theme.of(context).textTheme.bodyText1),
        ],
      );

  @override
  Widget appBar(BuildContext context) =>
      CustomAppBar(context: context, titleText: 'profile'.tr());

  @override
  Widget buildState(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppDimens.spacingXXLarge,
            AppDimens.spacingXXLarge, AppDimens.spacingXXLarge, 0),
        child: Stack(
          children: [
            PositionedDirectional(
              start: 0,
              end: 0,
              child: CircleAvatar(
                radius: 65,
                backgroundColor: AppColors.midGrey,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 65),
              padding: EdgeInsets.fromLTRB(AppDimens.spacingXLarge, 65,
                  AppDimens.spacingXLarge, AppDimens.spacingXLarge),
              decoration: AppShapes.roundedRectDecoration(
                  color: AppColors.lightGrey, borderColor: AppColors.midGrey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Container(width: double.infinity),
                  _buildUserInfoColumn(),
                  SizedBox(height: AppDimens.spacingXXLarge),
                  _buildContactInfoColumn(),
                  SizedBox(height: AppDimens.spacingXLarge),
                  if (userProvider.userMap['address'] != null)
                    _buildAddressesColumn(context),
                  SizedBox(height: AppDimens.spacingXXXLarge),
                  editProfileButton(),
                ],
              ),
            ),
            PositionedDirectional(
              start: 0,
              end: 0,
              child: _buildUserImage(),
            )
          ],
        ),
      ),
    );
  }

  editProfileButton() => FlatButton(
        splashColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingLarge),
        minWidth: double.infinity,
        onPressed: () =>
            Navigator.of(context).pushNamed(EditProfileScreen.routeName),
        shape: AppShapes.roundedRectShape(borderColor: AppColors.red),
        child: Text('edit_profile'.tr(),
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: AppColors.red)),
      );
}
