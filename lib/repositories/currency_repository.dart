import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/currency.dart';
import 'package:fad_shee/network/api_service.dart';
import 'package:fad_shee/network/result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CurrencyRepository {
  List<Currency> supportedCurrencies = [USD(), IraqiDinar()];
  Currency appCurrency;

  // Called after fetching exchange rate from server
  Future<bool> init() async {
    Result result = await getIt.get<ApiService>().currencies.fetchExchangeRate();
    if (result.isSuccessful) {
      updateIraqiDinarRate(result.result as double);
      String currencyId = await getIt<FlutterSecureStorage>().read(key: 'currency_id');
      // Default currency is USD
      updateAppCurrency(int.parse(currencyId ?? Currency.usdId.toString()));
      return true;
    }
    return false;
  }

  updateIraqiDinarRate(double rate) {
    supportedCurrencies[1].exchangeRate = rate;
  }

  // called when user select currency from account section
  updateAppCurrency(int currencyId) {
    if (appCurrency != null && currencyId == appCurrency.id) return;
    getIt<FlutterSecureStorage>().write(key: 'currency_id', value: currencyId.toString());
    switch (currencyId) {
      case Currency.iraqiDinarId:
        appCurrency = supportedCurrencies[1];
        break;
      default:
        appCurrency = supportedCurrencies[0];
    }
    appCurrencySymbol = appCurrency.symbol;
  }
}
