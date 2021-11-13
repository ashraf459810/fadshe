import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/brand.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';

class BrandRepository {
  List<Brand> _brands = [];

  List<Brand> get brands => [..._brands];

  Future<Result> fetchBrands() async {
    Result result = await getIt.get<ApiService>().brands.fetchBrands();
    if (result.isSuccessful) _brands = result.result as List<Brand>;
    return result;
  }
}
