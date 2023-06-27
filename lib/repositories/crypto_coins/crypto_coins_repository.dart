import 'package:cripto_coins/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;

  CryptoCoinsRepository({required this.dio});
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,CAG,DOV&tsyms=USD');
    // print(response);
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final detail = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(name: e.key, detail: detail);
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final detail = CryptoCoinDetail.fromJson(usdData);
    return CryptoCoin(detail: detail, name: currencyCode);
  }
}
