import 'package:dio/dio.dart';
import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/network/api_request.dart';
import 'package:fad_shee/network/dio_http_client.dart';
import 'package:fad_shee/network/result.dart';

class Products extends ApiRequest {
  Future<Result> fetchNewArrivalProducts() async {
    String url = '${DioHttpClient.baseUrl}/Items?orderBy=random';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<Product> products =
            ((jsonData['Items'] as dynamic)['data'] as List)
                .map((e) => Product.fromJson(e))
                .toList();
        print(" here the image from${products[0].images}");
        return Result(isSuccessful: true, result: products);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> fetchTrendingProducts() async {
    String url = '${DioHttpClient.baseUrl}/Items';
    // try {
    Response response =
        await getIt.get<Dio>().get(url, queryParameters: {'isHot': true});
    var jsonData = response.data;
    if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
      List<Product> products = (jsonData['Items']['data'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return Result(isSuccessful: true, result: products);
    } else {
      return Result(isSuccessful: false, message: jsonData['Reason']);
    }
    // } catch (error) {
    //   print(error);
    //   return handleError(error);
    // }
  }

  Future<Result> fetchCategoryProductsPage(int categoryId, int page) async {
    String url = '${DioHttpClient.baseUrl}/Items';
    try {
      Response response = await getIt
          .get<Dio>()
          .get(url, queryParameters: {'categories_id': categoryId});
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<Product> products =
            ((jsonData['Items'] as dynamic)['data'] as List)
                .map((e) => Product.fromJson(e))
                .toList();
        return Result(isSuccessful: true, result: products);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> fetchProductDetails(int productId) async {
    String url = '${DioHttpClient.baseUrl}/Items/$productId';
    try {
      Response response = await getIt.get<Dio>().get(url);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        return Result(
            isSuccessful: true, result: Product.fromJson(jsonData['Item']));
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> searchProducts(Map<String, dynamic> filters, int page) async {
    String url = '${DioHttpClient.baseUrl}/Items';
    try {
      Response response =
          await getIt.get<Dio>().get(url, queryParameters: filters);
      var jsonData = response.data;
      if (response.statusCode == 200 && jsonData['AZSVR'] == 'SUCCESS') {
        List<Product> products =
            ((jsonData['Items'] as dynamic)['data'] as List)
                .map((e) => Product.fromJson(e))
                .toList();
        return Result(isSuccessful: true, result: {
          'products': products,
          "last_page": (jsonData['Items'] as dynamic)['last_page'] as int
        });
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> rateProduct(int productId, int rate) async {
    String url = '${DioHttpClient.baseUrl}/Rates';
    try {
      Response response = await getIt
          .get<Dio>()
          .post(url, queryParameters: {'items_id': productId, 'rate': rate});
      var jsonData = response.data;
      if (response.statusCode == 200) {
        return Result(isSuccessful: true);
      } else {
        return Result(isSuccessful: false, message: jsonData['Reason']);
      }
    } catch (error) {
      print(error);
      return handleError(error);
    }
  }

  Future<Result> addComment(int productId, String comment) async {
    String url = '${DioHttpClient.baseUrl}/Comments';
    try {
      Response response = await getIt.get<Dio>().post(url,
          queryParameters: {'items_id': productId, 'comment': comment});
      var jsonData = response.data;
      if (response.statusCode == 200) {
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
