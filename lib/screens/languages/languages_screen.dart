import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/languages/widgets/languages_list.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LanguagesScreen extends StatefulWidget {
  static const routeName = '/languages';

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends BaseScreenState<LanguagesScreen> {
  @override
  Widget appBar(BuildContext ctx) => CustomAppBar(context: ctx, titleText: 'languages'.tr());

  @override
  Widget buildState(BuildContext context) {
    return LanguagesList();
  }
}
