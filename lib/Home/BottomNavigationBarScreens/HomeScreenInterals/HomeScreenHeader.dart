// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class HomeScreenHeader extends StatelessWidget {
  String nameText;

  HomeScreenHeader({
    super.key,
    required this.nameText,
  });

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(context: context, nameText: nameText);
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.context,
    required this.nameText,
  });

  final BuildContext context;
  final String nameText;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: Vx.m32,
      padding: Vx.mOnly(
        top: 32,
        left: 32,
        right: 32,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Ground Booking App".text.bold.xl4.color(context.theme.accentColor).make(),
          nameText.text.bold.xl4.color(context.theme.accentColor).make(),
        ],
      ),
    );
  }
}
