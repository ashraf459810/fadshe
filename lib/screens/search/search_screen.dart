import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/models/data/sort_by_option.dart';
import 'package:fad_shee/models/data/sort_direction.dart';
import 'package:fad_shee/screens/base_screen_state.dart';
import 'package:fad_shee/screens/search/search_provider.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:fad_shee/theme/AppDimes.dart';
import 'package:fad_shee/theme/AppShapes.dart';
import 'package:fad_shee/widgets/custom_app_bar.dart';
import 'package:fad_shee/widgets/custom_dropdown.dart';
import 'package:fad_shee/widgets/custom_text_field.dart';
import 'package:fad_shee/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseScreenState<SearchScreen> {
  SearchProvider provider;

  @override
  onBuildStart() {
    provider = Provider.of<SearchProvider>(context);
  }

  @override
  Widget appBar(BuildContext context) => CustomAppBar(context: context, titleText: 'search'.tr());

  @override
  Widget buildState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimens.spacingLarge, right: AppDimens.spacingLarge, top: AppDimens.spacingLarge),
      child: SingleChildScrollView(
        controller: provider.scrollController,
        child: Form(
          key: provider.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchTextField(),
              SizedBox(height: AppDimens.spacingSmall),
              categoryDropDown(),
              SizedBox(height: AppDimens.spacingSmall),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        showBorder: true,
                        hint: 'max_delivery_days'.tr(),
                        backingFieldMap: provider.data,
                        backingFieldName: 'days',
                      ),
                    ),
                    SizedBox(width: AppDimens.spacingSmall),
                    Expanded(
                      child: CustomTextField(
                        showBorder: true,
                        hint: 'quantity_needed'.tr(),
                        backingFieldMap: provider.data,
                        backingFieldName: 'quantity',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: AppDimens.spacingSmall),
              sortDropdown(),
              Container(
                margin: EdgeInsets.only(top: AppDimens.spacingSmall),
                decoration: AppShapes.roundedRectDecoration(borderColor: AppColors.midGrey),
                child: CheckboxListTile(
                  activeColor: AppColors.red,
                  title: Text('show_only_with_discount'.tr()),
                  value: provider.showOnlyWithDiscount,
                  onChanged: (isChecked) {
                    provider.showOnlyWithDiscount = isChecked;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(height: AppDimens.spacingLarge),
              searchButton(context),
              Padding(
                padding: EdgeInsets.all(AppDimens.spacingMedium),
                child: provider.searchResults.isEmpty ? emptyState() : ProductsList(provider.searchResults),
              )
            ],
          ),
        ),
      ),
    );
  }

  searchTextField() => CustomTextField(
        showBorder: true,
        borderColor: AppColors.midGrey,
        hint: 'type_your_search_keyword'.tr(),
        backingFieldMap: provider.data,
        backingFieldName: 'title',
        padding: EdgeInsets.all(AppDimens.spacingMedium),
        keyboardType: TextInputType.text,
        prefixIcon: Icon(Icons.search, size: AppDimens.iconSizeLarge, color: AppColors.midGrey),
        autoFocus: true,
        /*onChanged: (value) {
          if (value.isEmpty) provider.searchProduct();
        },*/
      );

  categoryDropDown() {
    return CustomDropdown(
      textAlign: AlignmentDirectional.centerStart,
      hint: 'select_category'.tr(),
      options: provider.categories,
      showBorder: true,
      selectedOption: provider.selectedCategory,
      onOptionSelected: (option) {
        provider.selectedCategory = option;
      },
    );
  }

  sortDropdown() => Row(
        children: [
          Expanded(
            child: CustomDropdown(
              textAlign: AlignmentDirectional.centerStart,
              hint: 'sort_by'.tr(),
              options: provider.sortByOptions,
              showBorder: true,
              selectedOption: provider.sortByOptions.firstWhere((element) => element.id == provider.selectedSortByOptionId),
              onOptionSelected: (option) {
                provider.selectedSortByOptionId = (option as SortByOption).id;
              },
            ),
          ),
          SizedBox(width: AppDimens.spacingSmall),
          Expanded(
            child: CustomDropdown(
              textAlign: AlignmentDirectional.centerStart,
              options: provider.sortDirections,
              showBorder: true,
              selectedOption: provider.sortDirections.firstWhere((element) => element.id == provider.selectedSortDirectionId),
              onOptionSelected: (option) {
                provider.selectedSortDirectionId = (option as SortDirection).id;
              },
            ),
          ),
        ],
      );

  Widget searchButton(BuildContext context) => FlatButton.icon(
        onPressed: () => provider.searchProduct(),
        height: 40,
        minWidth: 120,
        shape: AppShapes.roundedRectShape(radius: 5),
        color: AppColors.red,
        icon: Icon(Icons.search_rounded, color: Colors.white, size: 20),
        label: Text('search'.tr().toUpperCase(), style: Theme.of(context).textTheme.button.copyWith(color: Colors.white)),
      );

  emptyState() => Padding(
        padding: const EdgeInsets.only(top: AppDimens.spacingXXXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            Icon(Icons.search_off_sharp, size: 65, color: AppColors.midGrey),
            SizedBox(height: AppDimens.spacingLarge),
            Text(
              'no_results_found'.tr(),
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.blueGrey.withOpacity(0.3)),
            )
          ],
        ),
      );
}
