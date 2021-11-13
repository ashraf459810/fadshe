import 'package:fad_shee/main.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';
import 'package:fad_shee/repositories/base_repository.dart';
import 'package:fad_shee/repositories/cart_repository.dart';

class OrderRepository extends BaseRepository {
  Future<Result> fetchOrders() async {
    return await getIt.get<ApiService>().orders.fetchOrders();
  }

  Future<Result> placeAnOrder(int paymentMethodId, {String promoCode}) async {
    Result result = await getIt.get<ApiService>().orders.placeAnOrder(paymentMethodId, promoCode: promoCode);
    if (result.isSuccessful) getIt<CartRepository>().clearData();
    return result;
  }

  Future<Result> placeCustomOrder(Map<String, String> data) async {
    Result result = await getIt.get<ApiService>().orders.placeCustomOrder(data);
    return result;
  }

  Future<Result> acceptOrder(int orderId, bool accept) async {
    Result result = await getIt.get<ApiService>().orders.acceptOrder(orderId, accept);
    return result;
  }

  @override
  clearData() {
    // No Clear is needed because no data is stored
  }
}
