import 'package:flutter/material.dart';

void main() => runApp(const BottomSheetApp());

class BottomSheetApp extends StatelessWidget {
  const BottomSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Bottom Sheet Sample')),
        body: const BottomSheetExample(),
      ),
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Text("data");
              //       return SizedBox(
              //         height: 450,
              //         child: Column(
              //           children: <Widget>[
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 40, top: 40, right: 8),
              //                   child: Image.asset("assets/Icons.png"),
              //                 ),
              //                 Padding(
              //                     padding: const EdgeInsets.only(left: 8, top: 40, right: 10),
              //                     child: RichText(
              //                       text: TextSpan(
              //                         children: const <TextSpan>[
              //                           TextSpan(
              //                               text: 'Connect Wallet',
              //                               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color.fromARGB(255, 0, 0, 0))),
              //                         ],
              //                       ),
              //                     )),
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 70, top: 40),
              //                   child: IconButton(
              //                     icon: const Icon(Icons.close),
              //                     onPressed: () => Navigator.pop(context),
              //                   ),
              //                 )
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 40, top: 32, right: 8, bottom: 10),
              //                   child: Image.asset("assets/metamask.png"),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 32, right: 0, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(text: ' MetaMask', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 32, left: 100, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(
              //                             text: ' Connect',
              //                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color.fromARGB(255, 192, 135, 49))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             const Divider(
              //               height: 20,
              //               thickness: 0.25,
              //               indent: 40,
              //               endIndent: 45,
              //               color: Color.fromARGB(255, 153, 150, 150),
              //             ),
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 40, top: 10, right: 8, bottom: 10),
              //                   child: Image.asset("assets/coin.png"),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 10, right: 0, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(text: ' CoinBase Wallet', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 10, left: 65, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(
              //                             text: ' Connect',
              //                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color.fromARGB(255, 192, 135, 49))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             const Divider(
              //               height: 20,
              //               thickness: 0.25,
              //               indent: 40,
              //               endIndent: 45,
              //               color: Color.fromARGB(255, 153, 150, 150),
              //             ),
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 40, top: 10, right: 8, bottom: 10),
              //                   child: Image.asset("assets/wallet.png"),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 10, right: 0, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(text: ' WalletConnect', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 10, left: 75, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(
              //                             text: ' Connect',
              //                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color.fromARGB(255, 192, 135, 49))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             const Divider(
              //               height: 20,
              //               thickness: 0.25,
              //               indent: 40,
              //               endIndent: 45,
              //               color: Color.fromARGB(255, 153, 150, 150),
              //             ),
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 40, top: 10, right: 8, bottom: 10),
              //                   child: Image.asset("assets/fort.png"),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 10, right: 0, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(text: ' Fortmatic', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 10, left: 105, bottom: 10),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       children: const <TextSpan>[
              //                         TextSpan(
              //                             text: ' Connect',
              //                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color.fromARGB(255, 192, 135, 49))),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             )
              //             // const Text('Modal BottomSheet'),
              //             // ElevatedButton(
              //             //   child: const Text('Close BottomSheet'),
              //             //   onPressed: () => Navigator.pop(context),
              //             // ),
              //           ],
              //         ),
              // );
            },
          );
        },
      ),
    );
  }
}
