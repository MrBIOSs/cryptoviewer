import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:crypto_viewer/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_viewer/features/crypto_list/service/crypto_list_bloc.dart';
import 'package:crypto_viewer/features/crypto_list/widgets/widgets.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<ICryptoCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(const LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crypto Viewer')
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final coin = state.coinsList[index];
                  return CryptoCoinTile(coin: coin);
                }
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Something went wrong',
                      style: textTheme.headlineMedium),
                    Text('Please try again later',
                      style: textTheme.labelSmall?.copyWith(fontSize: 16)),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () => _cryptoListBloc.add(const LoadCryptoList()),
                      child: const Text('Try again')
                    )
                  ]
                )
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        )
      )
    );
  }
}
