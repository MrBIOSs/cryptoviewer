import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:crypto_viewer/repositories/crypto_coins/crypto_coins.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc(this.coinsRepository) : super(CryptoCoinInitial()) {
    on<LoadCryptoCoinDetails>(_load);
  }

  final ICryptoCoinsRepository coinsRepository;

  Future<void> _load(
    LoadCryptoCoinDetails event,
    Emitter<CryptoCoinState> emit
  ) async {
    try {
      emit(CryptoCoinDetailsLoading());
      final coinDetails =
          await coinsRepository.getCoinDetails(event.currencyCode);
      emit(CryptoCoinDetailsLoaded(coin: coinDetails));
    } catch (error) {
      emit(CryptoCoinDetailsLoadingFailure(exception: error));
    }
  }
}
