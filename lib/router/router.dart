import 'package:auto_route/auto_route.dart';
import 'package:cripto_coins/features/crypto_coin/crypto_coin.dart';
import 'package:cripto_coins/features/crypto_list/view/view.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}
