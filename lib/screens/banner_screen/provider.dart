import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class BannerProvider with ChangeNotifier {
  List<dynamic> bannersProducts = [];
  String url = '';
  List<dynamic> get productss => bannersProducts;
  Future getBannersList(String url) async {
    log(url);
    var response =
        await getIt.get<Dio>().get('https://fadshee.com/api/Items?title=$url');
    var jsonData = response.data;

    if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
      bannersProducts =
          (jsonData['Items']['data']).map((e) => Product.fromJson(e)).toList();
      notifyListeners();
      return bannersProducts;
    }
  }
}

// ignore: missing_return

