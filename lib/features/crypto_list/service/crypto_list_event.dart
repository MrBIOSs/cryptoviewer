part of 'crypto_list_bloc.dart';

sealed class CryptoListEvent extends Equatable {
  const CryptoListEvent();
}

final class LoadCryptoList extends CryptoListEvent {
  const LoadCryptoList({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
