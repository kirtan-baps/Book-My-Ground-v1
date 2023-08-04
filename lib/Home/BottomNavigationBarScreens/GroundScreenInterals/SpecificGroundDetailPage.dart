// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../../utils/routes.dart';
// import '../../utils/static_things.dart';

// class SpecificObjectDetail extends StatelessWidget {
//   const SpecificObjectDetail({super.key, required this.indexTransferForSpecificData});
//   final int indexTransferForSpecificData;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//         ),
//         backgroundColor: context.canvasColor,
//         body: SafeArea(
//           bottom: false,
//           child: Column(
//             children: [
//               Image.network(
//                 // "http://10.0.2.2/Flutter/image_and_text_upload_fetch2/${widget.ground_Data_T["image"]}",
//                 // "http://${MyRoutes.ip}/Flutter/image_and_text_upload_fetch2/${widget.ground_Data_T["image"]}",
//                 'http://${MyRoutes.ip}/Capstone/manager_panel_2/${StaticThings.groundPageList[indexTransferForSpecificData]["image"]}',

//                 fit: BoxFit.cover,
//               ),
//               Center(
//                 child: Text(
//                   "${StaticThings.groundPageList[indexTransferForSpecificData]['name']}",
//                   style: const TextStyle(
//                     color: Colors.amber,
//                     fontSize: 50,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     ;
//   }
// }
