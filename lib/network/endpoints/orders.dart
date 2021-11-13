import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/order.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Orders extends ApiRequest {
  Future<Result> fetchOrders() async {
    String url = '${DioHttpClient.baseUrl}/Orders/ListMyOrders';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<Order> orders = (jsonData['MyOrders'] as List).map((e) => Order.fromJson(e)).toList();
        return Result(isSuccessful: true, result: orders);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> placeAnOrder(int paymentMethodId, {String promoCode}) async {
    String url = '${DioHttpClient.baseUrl}/Orders/PlaceOrder';
    try {
      Response response = await getIt
          .get<Dio>()
          .get(url, queryParameters: {'payment_methods_id': paymentMethodId, 'promoCode': promoCode});
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(
            isSuccessful: true, message: 'your_order_placed_successfully'.tr(), result: jsonData['InvoiceID']);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> placeCustomOrder(Map<String, String> data) async {
    String url = '${DioHttpClient.baseUrl}/Orders/CustomPlaceOrder';
    try {
      Response response = await getIt.get<Dio>().get(url, queryParameters: data);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(isSuccessful: true, message: 'Your order has been placed successfully :)');
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> acceptOrder(int orderId, bool accept) async {
    String url = '${DioHttpClient.baseUrl}/Orders/AcceptOrRejectOrder/$orderId/$accept';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(
            isSuccessful: true, message: 'Your order has been ${accept ? 'accepted' : 'cancelled'} successfully :)');
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }
}
