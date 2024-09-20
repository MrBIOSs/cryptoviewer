part of 'crypto_coin_bloc.dart';

sealed class CryptoCoinEvent extends Equatable {
  const CryptoCoinEvent();

  @override
  List<Object> get props => [];
}

final class LoadCryptoCoinDetails extends CryptoCoinEvent {
  const LoadCryptoCoinDetails({required this.currencyCode});
  final String currencyCode;

  @override
  List<Object> get props => super.props..add(currencyCode);
}
