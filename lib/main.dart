import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:crypto_viewer/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_viewer/app/app.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final dio = Dio();

    _initTalker(dio);
    await _initHive(dio);

    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

    runApp(const CryptoViewerApp());
  }, (error, stackTrace) => GetIt.I<Talker>().handle(error, stackTrace));
}

void _initTalker(Dio dio) {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');
  _initTalkerDio(talker, dio);
  _initTalkerBloc(talker);
}

void _initTalkerDio(Talker talker, Dio dio) {
  dio.interceptors.add(
      TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(printResponseData: false)
      )
  );
}

void _initTalkerBloc(Talker talker) {
  Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
          printStateFullData: false,
          printEventFullData: false
      )
  );
}

Future<void> _initHive(Dio dio) async {
  await Hive.initFlutter();

  const cryptoCoinsBoxName = 'crypto_coins_box';

  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

  GetIt.I.registerLazySingleton<ICryptoCoinsRepository>(
        () => CryptoCoinsRepository(
      dio: dio,
      cryptoCoinsBox: cryptoCoinsBox
    )
  );
}
