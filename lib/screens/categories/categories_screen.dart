import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/categories/categories_provider.dart';
import 'package:fad_shee/screens/categories/widgets/categories_grid.dart';
import 'package:fad_shee/screens/category_details/category_details_provider.dart';
import 'package:fad_shee/screens/home/widgets/search_field.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends BaseScreenState<CategoriesScreen> {
  CategoriesProvider provider;
  CategoryDetailsProvider categoryItemsProvider;

  @override
  onBuildStart() {
    provider = Provider.of<CategoriesProvider>(context);
  }

  @override
  Widget buildState(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(color: AppColors.red, child: SearchField()),
          SizedBox(height: AppDimens.pagePadding),
          CategoriesGrid(provider.categories),
        ],
      ),
    );
  }
}
