part of 'crypto_coin_detail_bloc.dart';

class CryptoCoinDetailState extends Equatable {
  const CryptoCoinDetailState();

  @override
  List<Object> get props => [];
}

class CryptoCoinDetailLoading extends CryptoCoinDetailState {}

class CryptoCoinDetailsLoaded extends CryptoCoinDetailState {
  final CryptoCoin coin;

  const CryptoCoinDetailsLoaded(this.coin);
  @override
  List<Object> get props => [coin];
}

class CryptoCoinDetailsLoadingFailure extends CryptoCoinDetailState {
  final Object exeption;

  const CryptoCoinDetailsLoadingFailure(this.exeption);
  @override
  List<Object> get props => [exeption];
}
