import 'package:cripto_coins/repositories/crypto_coins/models/crypto_coin_detail.dart';
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String name;
  final CryptoCoinDetail detail;

  const CryptoCoin({
    required this.detail,
    required this.name,
  });

  @override
  List<Object?> get props => [name, detail];
}
