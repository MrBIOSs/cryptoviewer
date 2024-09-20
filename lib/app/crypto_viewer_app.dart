import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:crypto_viewer/router/router.dart';
import 'package:crypto_viewer/theme/theme.dart';

class CryptoViewerApp extends StatefulWidget {
  const CryptoViewerApp({super.key});

  @override
  State<CryptoViewerApp> createState() => _CryptoViewerAppState();
}

class _CryptoViewerAppState extends State<CryptoViewerApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Viewer',
      theme: darkTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.I<Talker>())
        ]
      )
    );
  }
}
