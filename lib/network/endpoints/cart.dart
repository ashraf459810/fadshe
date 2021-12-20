import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/cart_item.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Cart extends ApiRequest {
  Future<Result> fetchCartItems({String promoCode}) async {
    String url = '${DioHttpClient.baseUrl}/Cart/GetFinancials';
    try {
      Response response = await getIt.get<Dio>().get(url,
          queryParameters: promoCode != null ? {'promoCode': promoCode} : {});
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<CartItem> items = (jsonData['Carts'] as List)
            .map((e) => CartItem.fromJson(e))
            .toList();
        return Result(
            isSuccessful: true,
            deliveryDays: jsonData['DeliveryDays'].toString(),
            result: MapEntry(jsonData['CartsTotal'].toDouble(), items));
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> addToCart(
      int productId, int quantity, String attributes) async {
    String url = '${DioHttpClient.baseUrl}/Cart/Add';
    try {
      Response response = await getIt.get<Dio>().get(url, queryParameters: {
        'items_id': productId,
        'quantity': quantity,
        'attributes': attributes,
      });
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true, result: jsonData['NewCartID']);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> removeFromCart(int itemId) async {
    String url = '${DioHttpClient.baseUrl}/Cart/Remove/$itemId';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> updateItemQuantity(int itemId, int quantity) async {
    String url = '${DioHttpClient.baseUrl}/Cart/Update/$itemId';
    try {
      Response response = await getIt
          .get<Dio>()
          .get(url, queryParameters: {'quantity': quantity});
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> fetchCartTotal({String promoCode}) async {
    String url = '${DioHttpClient.baseUrl}/Cart/GetFinancialsTotal';
    try {
      Response response = await getIt.get<Dio>().get(url,
          queryParameters: promoCode != null ? {'promoCode': promoCode} : {});
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(
            isSuccessful: true,
            result: CartInfo(
                cartTotal: jsonData['CartsTotal'].toDouble(),
                cartFees: jsonData['DeliveryFees'].toDouble()));
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}

class CartInfo {
  final double cartFees;
  final double cartTotal;
  final String deliveryDays;

  CartInfo({this.deliveryDays, this.cartFees, this.cartTotal});
}
