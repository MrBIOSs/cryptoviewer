import 'package:crypto_viewer/repositories/crypto_coins/models/models.dart';

abstract interface class ICryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinDetails(String currencyCode);
}
