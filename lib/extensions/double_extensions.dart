import 'package:fad_shee/main.dart';
import 'package:fad_shee/models/data/currency.dart';
import 'package:fad_shee/repositories/currency_repository.dart';

extension DoubleExtensions on double {
  String currencyFormat({bool withSymbol = true}) {
    CurrencyRepository currencyRepo = getIt();
    Currency appCurrency = currencyRepo.appCurrency;
    return '${(this * appCurrency.exchangeRate).toStringAsFixed(this.truncateToDouble() == this ? 0 : appCurrency.decimalDigits)}${withSymbol ? currencyRepo.appCurrency.symbol : ''}';
  }
}
