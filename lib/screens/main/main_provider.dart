import 'dart:developer';

import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/user.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/banner_repository.dart';
import 'package:fad_shee/repositories/brand_repository.dart';
import 'package:fad_shee/repositories/cart_repository.dart';
import 'package:fad_shee/repositories/category_repository.dart';
import 'package:fad_shee/repositories/currency_repository.dart';
import 'package:fad_shee/repositories/home_slides_repository.dart';
import 'package:fad_shee/repositories/product_repository.dart';
import 'package:fad_shee/repositories/user_repository.dart';
import 'package:fad_shee/repositories/wish_list_repository.dart';
import 'package:fad_shee/screens/blocked_user.dart';
import 'package:flutter/foundation.dart';

class MainProvider with ChangeNotifier {
  bool loading = true;
  CategoryRepository categoryRepo = getIt();
  UserRepository userRepo = getIt();
  ProductRepository productRepo = getIt();
  HomeSlidesRepository homeSlidesRepo = getIt();
  WishListRepository wishListRepo = getIt();
  CartRepository cartRepo = getIt();
  CurrencyRepository currencyRepo = getIt();
  BannerRepository bannerRepo = getIt();
  BrandRepository brandRepo = getIt();
  String errorMessage;

  MainProvider() {
    init();
  }

  init() async {
    log("here from the user");
    log("${getIt<UserRepository>().user}");

    if (getIt<UserRepository>().user != null) {
      await _loadUserData();
      // tO Check if user is blocked
      bool continueToApp = await updateAccountStatus();
      if (!continueToApp)
        await navService.pushNamedAndRemoveUntil(BlockedUserScreen.routeName);
    }
    // To prevent fetching App Data after redirecting to '/' after login
    if (categoryRepo.categories.isEmpty) {
      await _loadAppData();
    }
    loading = false;
    notifyListeners();
  }

  Future _loadAppData() async {
    Result result = await categoryRepo.fetchCategories();
    if (result.isSuccessful) {
      result = await productRepo.fetchNewArrivalProducts();
      if (result.isSuccessful) {
        result = await productRepo.fetchTrendingProducts();
        if (result.isSuccessful) {
          result = await homeSlidesRepo.fetchSliderImages();
          if (result.isSuccessful) {
            result = await bannerRepo.fetchBanners();
            if (result.isSuccessful) {
              result = await brandRepo.fetchBrands();
              if (result.isSuccessful) {
                bool isSuccessful = await currencyRepo.init();
                if (!isSuccessful)
                  errorMessage = 'Failed initializing currency :(';
              }
            } else
              errorMessage = result.message;
          } else
            errorMessage = result.message;
        } else
          errorMessage = result.message;
      } else
        errorMessage = result.message;
    } else {
      errorMessage = result.message;
    }
  }

  Future _loadUserData() async {
    await wishListRepo.fetchWishListItems();
    await cartRepo.fetchCartItems();
  }

  Future<bool> updateAccountStatus() async {
    Result result = await userRepo.fetchUserData();
    if (result.isSuccessful && !(result.result as User).isActive) {
      return false;
    }
    return true;
  }
}
