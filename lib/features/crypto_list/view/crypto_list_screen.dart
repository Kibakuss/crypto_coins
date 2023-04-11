import 'package:cripto_coins/features/crypto_list/widgets/widgets.dart';
import 'package:cripto_coins/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoCurrenciesList'),
      ),
      body: _cryptoCoinsList == null
          ? const SizedBox()
          : ListView.separated(
              itemCount: _cryptoCoinsList!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];

                return CryotoCoinTile(coin: coin);
              },
            ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        _cryptoCoinsList = await CryptoCoinsRepository().getCoinsList();
        setState(() {});
      }),
    );
  }
}
