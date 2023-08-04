import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingWidgetOfPopularGroundHome extends StatelessWidget {
  const LoadingWidgetOfPopularGroundHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              LoadingWidgetOfPopularGroundHomeInternal(),
              LoadingWidgetOfPopularGroundHomeInternal(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              LoadingWidgetOfPopularGroundHomeInternal(),
              LoadingWidgetOfPopularGroundHomeInternal(),
            ],
          ),
        ],
      ),
    );
  }
}

class LoadingWidgetOfPopularGroundHomeInternal extends StatelessWidget {
  const LoadingWidgetOfPopularGroundHomeInternal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 18,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CardLoading(
        height: 160,
        // width: double.infinity,
        width: 170,
        cardLoadingTheme: CardLoadingTheme(colorOne: context.accentColor, colorTwo: context.backgroundColor),
        // margin: const EdgeInsets.only(bottom: 10),
      ),
    );
  }
}
