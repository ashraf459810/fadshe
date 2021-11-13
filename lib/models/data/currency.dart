import 'package:easy_localization/easy_localization.dart';

abstract class Currency {
  final int id;
  final String name;
  final String symbol;
  final int decimalDigits;
  double exchangeRate;

  Currency(this.id, this.name, this.symbol, this.decimalDigits, this.exchangeRate);

  static const int usdId = 1;
  static const int iraqiDinarId = 2;
}

class USD extends Currency {
  USD() : super(Currency.usdId, 'us_dollar'.tr(), '\$', 2, 1);
}

// this exchange rate will be updated from server later
class IraqiDinar extends Currency {
  IraqiDinar() : super(Currency.iraqiDinarId, 'iraqi_dinar'.tr(), 'IQD', 0, 1);
}
