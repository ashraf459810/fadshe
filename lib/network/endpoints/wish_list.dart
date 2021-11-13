import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/wish_list_item.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class WishList extends ApiRequest {
  Future<Result> fetchWishListItems() async {
    String url = '${DioHttpClient.baseUrl}/Wishlist';
    // try {
    Response response = await getIt.get<Dio>().get(url);
    var jsonData = response.data;
    if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
      List<WishListItem> items = (jsonData['Wishlist'] as List)
          .map((e) => WishListItem.fromJson(e))
          .toList();
      return Result(isSuccessful: true, result: items);
    } else {
      return Result(isSuccessful: false, message: jsonData['Reason']);
    }
    // } catch (error) {
    //   print(error);
    //   return handleError(error);
    // }
  }

  Future<Result> addToWishList(int productId) async {
    String url = '${DioHttpClient.baseUrl}/Wishlist/Add';
    try {
      Response response = await getIt
          .get<Dio>()
          .get(url, queryParameters: {'items_id': productId});
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true, result: jsonData['WishID']);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> removeFromWishList(int itemId) async {
    String url = '${DioHttpClient.baseUrl}/Wishlist/Remove/$itemId';
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
}
