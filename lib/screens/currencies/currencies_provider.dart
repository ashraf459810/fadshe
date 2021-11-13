import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/currency.dart';
import 'package:fad_shee/repositories/currency_repository.dart';
import 'package:flutter/foundation.dart';

class CurrenciesProvider with ChangeNotifier {
  CurrencyRepository currencyRepo = getIt<CurrencyRepository>();

  List<Currency> get currencies => currencyRepo.supportedCurrencies;

  updateAppCurrency(currencyId) {
    currencyRepo.updateAppCurrency(currencyId);
    navService.pop();
  }
}
