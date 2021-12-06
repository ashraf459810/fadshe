import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/categories/categories_provider.dart';
import 'package:fad_shee/screens/categories/widgets/categories_grid.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubcategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  @override
  _SubcategoriesScreenState createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends BaseScreenState<SubcategoriesScreen> {
  CategoriesProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of(context);
  }

  @override
  Widget appBar(BuildContext context) =>
      CustomAppBar(context: context, titleText: provider.categoryTitle);

  @override
  Widget buildState(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spacingMedium),
        child: CategoriesGrid(provider.categories),
      ),
    );
  }
}
