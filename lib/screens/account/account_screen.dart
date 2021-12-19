import 'package:cached_network_image/cached_network_image.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/screens/account/widgets/account_list.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/profile/profile_screen.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends BaseScreenState<AccountScreen> {
  UserProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of<UserProvider>(context);
  }

  Widget _buildHeader(BuildContext ctx) => Padding(
        padding: EdgeInsets.only(
            left: AppDimens.spacingXXLarge,
            right: AppDimens.spacingXXLarge,
            top: AppDimens.spacingXXLarge,
            bottom: AppDimens.spacingLarge),
        child: Row(
          mainAxisAlignment: provider.isLoggedIn
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            headerImage(),
            if (provider.isLoggedIn) userInfo(),
            SizedBox(width: AppDimens.spacingSmall),
            if (provider.isLoggedIn) profileButton(),
          ],
        ),
      );

  headerImage() => Container(
        height: 100,
        width: 100,
        child: provider.user?.imageUrl == null
            ? Container(
                // color: Colors.black,
                child: Expanded(
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              )
            : CircleAvatar(
                radius: 33,
                backgroundColor: Colors.white,
                backgroundImage: provider.isLoggedIn
                    ? CachedNetworkImageProvider(provider.user.imageUrl)
                    : AssetImage('assets/images/ic_profile_guest.png'),
              ),
      );

  userInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(provider.user.name,
                  style: Theme.of(context).textTheme.headline3),
              Text(provider.user.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.grey[500])),
            ],
          ),
        ),
      );

  profileButton() => IconButton(
        onPressed: () => Navigator.pushNamed(context, ProfileScreen.routeName),
        icon: Icon(
          Icons.edit,
          color: AppColors.red,
        ),
      );

  Widget _buildPageContent() {
    return ScrollConfiguration(
      behavior: ScrollBehavior()
        ..buildViewportChrome(context, null, AxisDirection.down),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: AppDimens.spacingXLarge,
                  right: AppDimens.spacingXLarge,
                  bottom: AppDimens.spacingXLarge),
              child: AccountList(logout: () => provider.logout()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildState(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: _buildPageContent(),
        )
      ],
    );
  }
}
