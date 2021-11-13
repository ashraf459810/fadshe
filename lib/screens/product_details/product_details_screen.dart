import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/attribute.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/models/data/value.dart';
import 'package:fad_shee/providers/user_provider.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/product_details/product_details_provider.dart';
import 'package:fad_shee/screens/product_details/widgets/comments_list.dart';
import 'package:fad_shee/screens/product_details/widgets/product_actions.dart';
import 'package:fad_shee/screens/product_details/widgets/product_images_page_view.dart';
import 'package:fad_shee/screens/product_details/widgets/rating_bar.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/custom_dropdown.dart';
import 'package:fad_shee/widgets/custom_text_field.dart';
import 'package:fad_shee/widgets/price_widget.dart';
import 'package:fad_shee/widgets/products_grid.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product_details';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends BaseScreenState<ProductDetailsScreen> {
  PageController pageController = PageController(viewportFraction: 0.95);
  ScrollController controller = ScrollController();
  ProductDetailsProvider provider;
  StreamSubscription subscription;
  FocusNode commentFocusNode;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      subscription = Provider.of<ProductDetailsProvider>(context, listen: false)
          .message
          .stream
          .listen((event) {
        Flushbar(message: event, duration: Duration(seconds: 3))..show(context);
      });
    });
    super.initState();
  }

  @override
  bool resizeToAvoidBottomInset() {
    // TODO: implement resizeToAvoidBottomInset
    return super.resizeToAvoidBottomInset();
  }

  @override
  onBuildStart() {
    provider = Provider.of<ProductDetailsProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(
        context: context,
        titleText: provider.productName,
        actions: provider.product != null
            ? [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end: AppDimens.spacingXSmall),
                  child: GestureDetector(
                    onTap: () => provider.toggleFavorite(),
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                          provider.product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                          size: 24),
                    ),
                  ),
                ),
              ]
            : [],
      );

  @override
  Widget buildState(BuildContext context) {
    return provider.productDetailsLoading
        ? initialLoading()
        : Stack(
            fit: StackFit.expand,
            children: [
              ScrollConfiguration(
                behavior: ScrollBehavior()
                  ..buildOverscrollIndicator(
                      context,
                      null,
                      ScrollableDetails(
                          direction: AxisDirection.down,
                          controller: controller)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: AppDimens.spacingXLarge),
                          height: 300,
                          child: ProductImagesPageView(
                            controller: pageController,
                            images: provider.product.images.split(",").first,
                          ),
                        ),
                        _buildPageIndicator(),
                        SizedBox(height: AppDimens.spacingMedium),
                        _buildProductNameAndPrice(),
                        _category(),
                        if (provider.product.description != null)
                          _buildProductDescription(),
                        productAttributesSelectors(),
                        if (Provider.of<UserProvider>(context).isLoggedIn)
                          _commentsSection(),
                        if (provider.similarProducts?.isNotEmpty ?? false)
                          Container(
                              height: AppDimens.spacingSmall,
                              color: AppColors.lightGrey),
                        if (provider.similarProducts?.isNotEmpty ?? false)
                          _buildSimilarProductsList(),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  // ChangeNotifierProvider (to toggle favorite)
                  child: ChangeNotifierProvider<Product>.value(
                    value: provider.product,
                    child: ProductActions(
                        product: provider.product,
                        attributesWithSelectedValues:
                            provider.selectedAttrValues),
                  ))
            ],
          );
  }

  Widget initialLoading() => Center(
        child: SpinKitCircle(color: AppColors.grey.withOpacity(0.3)),
      );

  Widget moreLoading() => SpinKitDoubleBounce(color: AppColors.lightGrey);

  Widget _buildPageIndicator() => Container(
        alignment: Alignment.center,
        child: SmoothPageIndicator(
            controller: pageController,
            count: 1,
            effect: SlideEffect(
              activeDotColor: AppColors.red,
              dotWidth: 10,
              dotHeight: 10,
              dotColor: AppColors.grey,
              paintStyle: PaintingStyle.fill,
            ),
            onDotClicked: (index) {}),
      );

  _buildProductNameAndPrice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppDimens.spacingLarge,
          AppDimens.spacingLarge, AppDimens.spacingLarge, 0),
      child: Row(
        children: [
          Expanded(
              child: Text(provider.product.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black))),
          SizedBox(width: AppDimens.spacingLarge),
          PriceWidget(
            price: provider.product.price,
            discount: provider.product.discount,
            priceStyle: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  _category() => Container(
        margin: EdgeInsetsDirectional.only(
            start: AppDimens.spacingLarge,
            top: AppDimens.spacingSmall,
            bottom: AppDimens.spacingLarge),
        padding: EdgeInsets.symmetric(
            horizontal: AppDimens.spacingXSmall, vertical: 2),
        decoration: AppShapes.roundedRectDecoration(
            radius: AppDimens.spacingXSmall, borderColor: AppColors.red),
        child: Text(provider.product.categoryName.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: AppColors.red)),
      );

  _buildProductDescription() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLarge),
        child: Text(
          provider.product.description,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: AppColors.grey.withOpacity(0.8)),
        ),
      );

  productAttributesSelectors() => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingLarge,
            vertical: AppDimens.spacingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...provider.selectedAttrValues.entries
                .map((e) => attributeSelector(e.key, e.value)),
          ],
        ),
      );

  attributeSelector(Attribute attribute, Value selectedValue) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(attribute.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: AppColors.blueGrey)),
          ),
          SizedBox(width: AppDimens.spacingMedium),
          Expanded(flex: 4, child: attributeDropDown(attribute, selectedValue)),
        ],
      ),
    );
  }

  attributeDropDown(Attribute attribute, Value selectedValue) {
    return CustomDropdown(
      hint: attribute.name,
      options: attribute.values,
      showBorder: true,
      selectedOption: selectedValue,
      onOptionSelected: (option) {
        provider.selectedAttrValues.update(attribute, (value) => option);
        setState(() {});
      },
    );
  }

  _commentsSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: AppDimens.spacingSmall, color: AppColors.lightGrey),
          SizedBox(height: AppDimens.spacingXLarge),
          if (provider.product.comments.isNotEmpty)
            sectionTitle('comments'.tr().toUpperCase()),
          if (provider.product.comments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              child: CommentsList(provider.product.comments),
            ),
          sectionTitle('comment_rate'.tr().toUpperCase()),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding,
                vertical: AppDimens.spacingLarge),
            child: ratingBar(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
            child: CustomTextField(
              hint: 'type_your_comment'.tr(),
              showBorder: true,
              controller: provider.commentController,
              padding: EdgeInsets.all(AppDimens.spacingMedium),
              lines: 6,
              focusNode: commentFocusNode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding,
                vertical: AppDimens.spacingXSmall),
            child: addCommentButton(),
          ),
          SizedBox(height: AppDimens.spacingXLarge),
        ],
      );

  Widget addCommentButton() {
    return Container(
        height: 50,
        alignment: AlignmentDirectional.centerStart,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            provider.addingComment
                ? SpinKitThreeBounce(color: AppColors.red, size: 25)
                : FlatButton(
                    onPressed: () => provider.addComment(),
                    color: AppColors.red,
                    shape: AppShapes.roundedRectShape(radius: 5),
                    child: Text(
                      'add_comment'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                  ),
          ],
        ));
  }

  Widget ratingBar() {
    return RatingBar(
      rating: provider.product.rating,
      onRatingSelected: (rating) {
        provider.rateProduct(rating);
      },
    );
  }

  _buildSimilarProductsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle('similar_products'.tr().toUpperCase()),
          SizedBox(height: AppDimens.spacingLarge),
          provider.similarProductsLoading
              ? moreLoading()
              : ProductsGrid(provider.similarProducts),
        ],
      ),
    );
  }

  sectionTitle(title) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: AppDimens.pagePadding, height: 1, color: Colors.black),
          Text('  $title  ',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black)),
        ],
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
