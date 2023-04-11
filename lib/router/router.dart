import 'package:cripto_coins/features/crypto_coin/crypto_coin.dart';
import 'package:cripto_coins/features/crypto_list/view/view.dart';

final routes = {
  '/': (context) => const CryptoListScreen(),
  '/coin': (context) => const CryptoCoinScreen(),
};
