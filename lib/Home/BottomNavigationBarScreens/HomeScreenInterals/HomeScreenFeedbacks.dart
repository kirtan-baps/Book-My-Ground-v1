import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreenFeedbacks extends StatelessWidget {
  const HomeScreenFeedbacks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: "Feedback ${index + 1}".text.make(),
        );
      },
    );
  }
}
