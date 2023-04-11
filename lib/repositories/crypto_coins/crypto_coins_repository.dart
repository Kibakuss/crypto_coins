import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
        'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB&tsyms=USD');
    // print(response);
    final data = response.data as Map<String, dynamic>;
    final cryptoCoinsList = data.entries
        .map((e) => CryptoCoin(
              name: e.key,
              priceInUSD: (e.value as Map<String, dynamic>)['USD'],
            ))
        .toList();
    return cryptoCoinsList;
  }
}
