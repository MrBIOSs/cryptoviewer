import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto_viewer/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinsRepository implements ICryptoCoinsRepository {
  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    try {
      cryptoCoinsList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (error) {
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }

    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,SOL,SUI,PEPE,XRP,BNB,USDT&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(name: e.key, details: details);
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (error) {
      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    return CryptoCoin(name: currencyCode, details: details);
  }
}
