import 'package:cripto_coins/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  CryptoCoinsRepository({required this.cryptoCoinsBox, required this.dio});
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    try {
      cryptoCoinsList = await _fecthCoinsListFromApi();

      final cryptoCoinsMap = {
        for (var element in cryptoCoinsList) element.name: element
      };
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }
    cryptoCoinsList.sort(
      (a, b) => b.detail.priceInUSD.compareTo(a.detail.priceInUSD),
    );
    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fecthCoinsListFromApi() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,CAG,DOV&tsyms=USD');

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
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
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
