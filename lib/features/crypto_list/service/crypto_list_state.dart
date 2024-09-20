part of 'crypto_list_bloc.dart';

sealed class CryptoListState extends Equatable {
  const CryptoListState();
}

final class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

final class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

final class CryptoListLoaded extends CryptoListState {
  const CryptoListLoaded({required this.coinsList});
  final List<CryptoCoin> coinsList;

  @override
  List<Object?> get props => [coinsList];
}

final class CryptoListLoadingFailure extends CryptoListState {
  const CryptoListLoadingFailure({this.exception});
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
