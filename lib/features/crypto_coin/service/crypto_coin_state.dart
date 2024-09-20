part of 'crypto_coin_bloc.dart';

sealed class CryptoCoinState extends Equatable {
  const CryptoCoinState();

  @override
  List<Object?> get props => [];
}

final class CryptoCoinInitial extends CryptoCoinState {}

final class CryptoCoinDetailsLoading extends CryptoCoinState {}

final class CryptoCoinDetailsLoaded extends CryptoCoinState {
  const CryptoCoinDetailsLoaded({required this.coin});
  final CryptoCoin coin;

  @override
  List<Object?> get props => [coin];
}

final class CryptoCoinDetailsLoadingFailure extends CryptoCoinState {
  const CryptoCoinDetailsLoadingFailure({required this.exception});
  final Object exception;

  @override
  List<Object?> get props => super.props..add(exception);
}
