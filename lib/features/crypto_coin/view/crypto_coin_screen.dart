import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:crypto_viewer/features/crypto_coin/widgets/widgets.dart';
import 'package:crypto_viewer/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_viewer/features/crypto_coin/service/crypto_coin_bloc.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {

  final _coinDetailsBloc = CryptoCoinBloc(GetIt.I<ICryptoCoinsRepository>());

  @override
  void initState() {
    _coinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: widget.coin.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: _coinDetailsBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailsLoaded) {
            final coin = state.coin;
            final coinDetails = coin.details;

            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.network(coinDetails.fullImageUrl)
                  ),
                  const SizedBox(height: 24),
                  Text(coin.name, style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  BaseCard(
                    child: Center(
                      child: Text(
                        '${coinDetails.priceInUSD} \$',
                        style: textTheme.titleMedium
                      )
                    )
                  ),
                  BaseCard(
                    child: Column(
                      children: [
                        DataRowWidget(
                          title: 'High 24 Hour',
                          value: '${coinDetails.high24Hour} \$'
                        ),
                        const SizedBox(height: 6),
                        DataRowWidget(
                          title: 'Low 24 Hour',
                          value: '${coinDetails.low24Hours} \$'
                        )
                      ]
                    )
                  )
                ]
              )
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}
