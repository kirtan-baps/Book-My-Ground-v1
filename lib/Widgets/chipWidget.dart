// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Home/Other Screens/SpecificGroundDetailPageUniversal.dart';

// class ChipWidgetClass {
//   static Widget buildChip(String label, Color color) {
//     return Chip(
//       labelPadding: const EdgeInsets.all(2.0),
//       avatar: CircleAvatar(
//         backgroundColor: Colors.white70,
//         child: Text(label[0].toUpperCase()),
//       ),
//       label: Text(
//         label,
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       backgroundColor: color,
//       elevation: 6.0,
//       shadowColor: Colors.grey[60],
//       padding: EdgeInsets.all(8.0),
//     );
//   }
// }

class ChipWidgetClass {
  static Widget buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }
}

class ChipForMatcisBall extends StatelessWidget {
  const ChipForMatcisBall({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final SpecificGroundDetailPageUniversal widget;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: context.cardColor,
        // child: Text("label"[0].toUpperCase()),
        backgroundImage: const AssetImage(
          'assets/images/balls/matchis_ball.jpg',
        ),
      ),
      label: Text(
        widget.tempListForSpecificDetail['pitch1'],
      ),
      // backgroundColor: context.accentColor,
      elevation: 6.0,
      shadowColor: context.cardColor,
      padding: const EdgeInsets.all(8.0),
    );
  }
}

class ChipForTennisBall extends StatelessWidget {
  const ChipForTennisBall({
    super.key,
    required this.widget,
  });

  final SpecificGroundDetailPageUniversal widget;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: context.cardColor,
        // child: Text("label"[0].toUpperCase()),
        backgroundImage: const AssetImage('assets/images/balls/tennis_ball.jpg'),
      ),
      label: Text(
        widget.tempListForSpecificDetail['pitch0'],
      ),
      // backgroundColor: context.accentColor,
      elevation: 6.0,
      shadowColor: context.cardColor,
      padding: const EdgeInsets.all(8.0),
    );
  }
}
