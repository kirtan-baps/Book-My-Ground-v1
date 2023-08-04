import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingWidgetOfGroundScreen extends StatelessWidget {
  const LoadingWidgetOfGroundScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 18,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CardLoading(
          height: 300,
          width: 400,
          cardLoadingTheme: CardLoadingTheme(colorOne: context.accentColor, colorTwo: context.backgroundColor),
          // margin: const EdgeInsets.only(bottom: 10),
        ),
      ),
    );
  }
}
