import 'dart:async';

import 'package:cripto_coins/crypto_coins_list_app.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'repositories/crypto_coins/abstract_coins_repository.dart';
import 'repositories/crypto_coins/crypto_coins_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker Started');

  const cryptoCoinsBoxName = 'crypto_coins_box';

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

  final dio = Dio();
  Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
          printEventFullData: false, printStateFullData: false));

  dio.interceptors.add(TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printResponseData: false)));
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox));

  FlutterError.onError = (details) {
    return GetIt.I<Talker>().handle(details.exception);
  };
  runZonedGuarded(() => runApp(const CryptoCurrenciesListApp()),
      (error, stack) {
    return GetIt.I<Talker>().handle(error, stack);
  });
}
