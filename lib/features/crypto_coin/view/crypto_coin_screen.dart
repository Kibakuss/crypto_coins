import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  CryptoCoin? coinFull;
  String? coinName;

  @override
  void didChangeDependencies() {
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    // assert(args != null && args is String, 'You must provide String args');
    // coinName = args as String;
    setState(() {
      coinFull = args as CryptoCoin;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coinFull?.name ?? '...')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 40, child: Image.network(coinFull!.imageUrl)),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black54,
              // height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text('Current Price')),
                  Expanded(child: Text('${coinFull?.priceInUSD} \$'))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black54,
              // height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text('Max Price 24 hours')),
                  Expanded(child: Text('${coinFull?.priceHighDay} \$'))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black54,
              // height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text('Low Price 24 hours')),
                  Expanded(child: Text('${coinFull?.priceLowDay} \$'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
