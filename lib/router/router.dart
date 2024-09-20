import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:crypto_viewer/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_viewer/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_viewer/features/crypto_list/crypto_list.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}

