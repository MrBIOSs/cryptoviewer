import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:crypto_viewer/router/router.dart';
import 'package:crypto_viewer/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final coinDetails = coin.details;
    final textTheme = Theme.of(context).textTheme;
    final router = AutoRouter.of(context);

    return ListTile(
      leading: Image.network(coinDetails.fullImageUrl),
      title: Text(coin.name, style: textTheme.bodyMedium),
      subtitle: Text('${coinDetails.priceInUSD} \$',
        style: textTheme.labelSmall),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => router.push(CryptoCoinRoute(coin: coin))
    );
  }
}
