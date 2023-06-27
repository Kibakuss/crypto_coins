part of 'crypto_coin_detail_bloc.dart';

abstract class CryptoCoinDetailEvent extends Equatable {
  const CryptoCoinDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadCryptoCoinDetails extends CryptoCoinDetailEvent {
  final String currencyCode;

  const LoadCryptoCoinDetails({required this.currencyCode});
  @override
  List<Object> get props => [currencyCode];
}
