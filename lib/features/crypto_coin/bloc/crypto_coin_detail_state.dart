part of 'crypto_coin_detail_bloc.dart';

class CryptoCoinDetailState extends Equatable {
  const CryptoCoinDetailState();

  @override
  List<Object> get props => [];
}

class CryptoCoinDetailLoading extends CryptoCoinDetailState {}

class CryptoCoinDetailsLoaded extends CryptoCoinDetailState {
  final CryptoCoinDetail coinDetails;

  const CryptoCoinDetailsLoaded(this.coinDetails);
  @override
  List<Object> get props => [coinDetails];
}

class CryptoCoinDetailsLoadingFailure extends CryptoCoinDetailState {
  final Object exeption;

  const CryptoCoinDetailsLoadingFailure(this.exeption);
  @override
  List<Object> get props => [exeption];
}
