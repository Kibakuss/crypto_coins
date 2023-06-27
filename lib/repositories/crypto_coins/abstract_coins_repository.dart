import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin_detail.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoinDetail> getCoinDetails(String currencyCode);
}
