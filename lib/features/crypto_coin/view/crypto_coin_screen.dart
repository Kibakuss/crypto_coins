import 'package:cripto_coins/features/crypto_coin/bloc/crypto_coin_detail_bloc.dart';
import 'package:cripto_coins/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  CryptoCoin? coin;
  final _coinDetailBloc =
      CryptoCoinDetailBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is CryptoCoin, 'You must provide String args');
    coin = args as CryptoCoin;
    _coinDetailBloc.add(LoadCryptoCoinDetails(currencyCode: coin!.name));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinDetailBloc, CryptoCoinDetailState>(
        bloc: _coinDetailBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailsLoaded) {
            final coin = state.coin;
            final coinDetails = coin.detail;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 40,
                      child: Image.network(coinDetails.fullImageUrl)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(coin.name),
                  Container(
                    color: Colors.black54,
                    // height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: Text('Current Price')),
                        Expanded(child: Text('${coinDetails.priceInUSD} \$'))
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
                        Expanded(child: Text('${coinDetails.hight24Hour} \$'))
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
                        Expanded(child: Text('${coinDetails.low24Hours} \$'))
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
