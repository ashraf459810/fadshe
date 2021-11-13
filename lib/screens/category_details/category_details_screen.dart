import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/category_details/category_details_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CategoryDetailsScreen extends StatefulWidget {
  static const routeName = '/category_details';

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends BaseScreenState<CategoryDetailsScreen> {
  ScrollController _scrollController = ScrollController();
  CategoryDetailsProvider provider;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) provider.loadMoreProducts();
    });
    super.initState();
  }

  @override
  onBuildStart() {
    provider = Provider.of<CategoryDetailsProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(context: context, titleText: provider.category.title);

  @override
  Widget buildState(BuildContext context) {
    return provider.loading
        ? initialLoading()
        : ScrollConfiguration(
            behavior: ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppDimens.spacingLarge, AppDimens.spacingLarge, AppDimens.spacingLarge, 0),
                child: Column(
                  children: [
                    ProductsList(provider.products),
                  ],
                ),
              ),
            ),
          );
  }

  initialLoading() => Center(
        child: SpinKitCircle(color: AppColors.grey.withOpacity(0.4)),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
