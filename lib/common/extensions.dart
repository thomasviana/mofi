import 'package:intl/intl.dart';

import '../di/dependency_injection.dart';

extension Flatten on Iterable<bool> {
  bool flatten() => fold(
        true,
        (a, b) => a && b,
      );
}

extension MyCurrencyFormat on num {
  static final _currencyWithPrefixSignAndSymbol =
      NumberFormat(' \$ #,##0;- \$ #,##0');
  static final _currencyZero = NumberFormat('\$ #,##0', 'en_US');

  String toCurrencyFormat() {
    return this == 0
        ? _currencyZero.format(this)
        : _currencyWithPrefixSignAndSymbol.format(this);
  }
}

extension MyPercentageFormat on num {
  static final _percentage = NumberFormat.percentPattern('ar');

  String toPercentFormat() {
    return _percentage.format(this);
  }
}

extension EnvironmentExt on Environment {
  bool get isUat => this == Environment.uat;

  bool get isProd => this == Environment.prod;
}
