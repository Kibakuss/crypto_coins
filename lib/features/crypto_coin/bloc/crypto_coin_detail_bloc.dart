import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cripto_coins/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:cripto_coins/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_detail_event.dart';
part 'crypto_coin_detail_state.dart';

class CryptoCoinDetailBloc
    extends Bloc<CryptoCoinDetailEvent, CryptoCoinDetailState> {
  CryptoCoinDetailBloc(this.coinsRepository)
      : super(const CryptoCoinDetailState()) {
    on<LoadCryptoCoinDetails>(_load);
  }
  final AbstractCoinsRepository coinsRepository;

  Future<void> _load(
      LoadCryptoCoinDetails event, Emitter<CryptoCoinDetailState> emit) async {
    try {
      if (state is! CryptoListLoaded) {
        emit(CryptoCoinDetailLoading());
      }
      final coinsDetails =
          await coinsRepository.getCoinDetails(event.currencyCode);
      emit(CryptoCoinDetailsLoaded(coinsDetails));
    } catch (e, st) {
      emit(CryptoCoinDetailsLoadingFailure(e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
