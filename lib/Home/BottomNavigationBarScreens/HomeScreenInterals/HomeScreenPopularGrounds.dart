import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../OtherScreens/LoadingWidgetOfPopularGroundHomeScreen.dart';
import '../../../utils/routes.dart';
import '../../../utils/static_things.dart';
import 'package:http/http.dart' as http;

import '../../Other Screens/SpecificGroundDetailPageUniversal.dart';

class HomeScreenPopularGrounds extends StatefulWidget {
  const HomeScreenPopularGrounds({super.key});

  @override
  State<HomeScreenPopularGrounds> createState() => _HomeScreenPopularGroundsState();
}

class _HomeScreenPopularGroundsState extends State<HomeScreenPopularGrounds> {
  Future homePagePopularGroundsData() async {
    try {
      var response = await http.get(
        Uri.http(
          MyRoutes.ip,
          '/Capstone/project_2/groundData/popular.php',
          {'q': '{http}'},
        ),
      );

      StaticThings.homePagePopularGroundsData = json.decode(response.body);
    } catch (e) {
      print(e);
    }
    return "Success!";
  }

  late Widget myWidget;
  @override
  void initState() {
    homePagePopularGroundsData();

    myWidget = homePagePopularGroundsDataFunction();
    super.initState();
  }

  Column homePagePopularGroundsDataFunction() {
    return Column(
      children: [
        FutureBuilder(
          future: homePagePopularGroundsData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // padding: Vx.m32,
                    padding: Vx.mOnly(
                      top: 32,
                      left: 32,
                      right: 32,
                      // bottom: 20,
                    ),
                    child: SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // const Text(
                          //   'Popular',
                          //   style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                          // ),
                          "Popular".text.xl2.make(),

                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.purple,
                              fontFamily: 'Bradley Hand ITC',
                              fontWeight: FontWeight.w500,
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                RotateAnimatedText(' Offers'),
                                RotateAnimatedText(' Grounds'),
                                // RotateAnimatedText(' '),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: StaticThings.homePagePopularGroundsData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SpecificGroundDetailPageUniversal(
                                    tempListForSpecificDetail: StaticThings.homePagePopularGroundsData[index],
                                    indexHero: index,
                                    listTrans: StaticThings.homePagePopularGroundsData,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                              // color: context.cardColor,
                              // color: context.theme.scaffoldBackgroundColor,
                              border: Border.all(
                                color: context.theme.accentColor,
                                // color: Colors.white70,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.elliptical(10, 10),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                              // bottom: 10,
                            ),
                            child: Container(
                              // color: Colors.black,
                              height: 150,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.elliptical(10, 10),
                                      bottomRight: Radius.elliptical(10, 10),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.network(
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        'http://${MyRoutes.ip}/Capstone/manager_panel_3/${StaticThings.homePagePopularGroundsData[index]["image"]}'),
                                    // child: Hero(
                                    //   tag: 'item_$index', // Use the same unique tag as in the GridView.builder
                                    //   child: Image.network(
                                    //       height: 100,
                                    //       width: double.infinity,
                                    //       fit: BoxFit.cover,
                                    //       'http://${MyRoutes.ip}/Capstone/manager_panel_3/${StaticThings.homePagePopularGroundsData[index]["image"]}'),
                                    // ),
                                  ),
                                  SizedBox(
                                    width: 250.0,
                                    height: 25,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: DefaultTextStyle(
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: context.accentColor,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 7.0,
                                                color: context.accentColor,
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedTextKit(
                                            repeatForever: true,
                                            animatedTexts: [
                                              FlickerAnimatedText('Lets Play'),
                                              FlickerAnimatedText('Lets Book'),
                                              FlickerAnimatedText("Lets Go"),
                                            ],
                                            onTap: () {
                                              print("Tap Event");
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    StaticThings.homePagePopularGroundsData[index]["name"],
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      // color: Colors.black,
                                      // color: context.theme.accentColor,
                                      color: context.accentColor,
                                      // fontSize: 25,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const LoadingWidgetOfPopularGroundHome();
            }
          },
        ),
      ],
    );
  }

  int _selectedIndex = 0;
  final Map<int, Widget> _segmentedControlChildren = {
    0: const Text('Populars'),
    1: const Text('High Rated'),
    // 2: const Text('Option 3'),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: Vx.mOnly(
            top: 32,
            left: 32,
            right: 32,
            // bottom: 20,
          ),
          child: Center(
            child: CupertinoSlidingSegmentedControl<int>(
              children: _segmentedControlChildren,
              onValueChanged: (index) {
                // setState(() {
                //   _selectedIndex = index!;
                // });
                setState(() {
                  _selectedIndex = index!;
                  if (_selectedIndex == 0) {
                    myWidget = homePagePopularGroundsDataFunction();
                  } else if (index == 1) {
                    myWidget = Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // padding: Vx.m32,
                          padding: Vx.mOnly(
                            top: 32,
                            left: 32,
                            right: 32,
                            // bottom: 20,
                          ),
                          child: SizedBox(
                            height: 45,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // const Text(
                                //   'Popular',
                                //   style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                                // ),
                                "High Rated".text.xl2.make(),

                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.purple,
                                    fontFamily: 'Bradley Hand ITC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      RotateAnimatedText(' Grounds'),
                                      RotateAnimatedText(' Bookings'),
                                      // RotateAnimatedText(' '),
                                    ],
                                    onTap: () {
                                      print("Tap Event");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  // color: context.cardColor,
                                  // color: context.theme.scaffoldBackgroundColor,
                                  border: Border.all(
                                    color: context.theme.accentColor,
                                    // color: Colors.white70,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.elliptical(10, 10),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  // bottom: 10,
                                ),
                                child: Container(
                                  // color: Colors.black,
                                  height: 150,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.elliptical(10, 10),
                                          bottomRight: Radius.elliptical(10, 10),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                            height: 100,
                                            fit: BoxFit.fill,
                                            'https://media.istockphoto.com/id/180868820/photo/cricket-batsman-about-to-strike-ball.jpg?s=612x612&w=0&k=20&c=xRiAIk3RA6cmm1FtI2S-YK8Pei9qSkqxhX-JUbTI2Cs='),
                                      ),
                                      SizedBox(
                                        width: 250.0,
                                        height: 25,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: DefaultTextStyle(
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: context.accentColor,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 7.0,
                                                    color: context.accentColor,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              child: AnimatedTextKit(
                                                repeatForever: true,
                                                animatedTexts: [
                                                  FlickerAnimatedText('Lets Play'),
                                                  FlickerAnimatedText('Lets Book'),
                                                  FlickerAnimatedText("Lets Go"),
                                                ],
                                                onTap: () {
                                                  print("Tap Event");
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      const Text('Ground Name'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    myWidget = const CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  }
                });
              },
              groupValue: _selectedIndex,
            ),
          ),
        ),
        // _widgetOptions[_selectedIndex],
        myWidget,
      ],
    );
  }

  // final List<Widget> _widgetOptions = [
  //   // Widget 1
//     Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//  Container(
//                 // padding: Vx.m32,
//                 padding: Vx.mOnly(
//                   top: 32,
//                   left: 32,
//                   right: 32,
//                   // bottom: 20,
//                 ),
//                 child: SizedBox(
//                   height: 45,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       // const Text(
//                       //   'Popular',
//                       //   style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
//                       // ),
//                       "Popular".text.xl2.make(),

//                       DefaultTextStyle(
//                         style: const TextStyle(
//                           fontSize: 20.0,
//                           color: Colors.purple,
//                           fontFamily: 'Bradley Hand ITC',
//                           fontWeight: FontWeight.w500,
//                         ),
//                         child: AnimatedTextKit(
//                           animatedTexts: [
//                             RotateAnimatedText(' Offers'),
//                             RotateAnimatedText(' Grounds'),
//                             // RotateAnimatedText(' '),
//                           ],
//                           onTap: () {
//                             print("Tap Event");
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )

//         FutureBuilder(
//           future: homePagePopularGroundsData(),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 shrinkWrap: true,
//                 physics: const ClampingScrollPhysics(),
//                 itemCount: StaticThings.homePagePopularGroundsData.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return SpecificGroundDetailPageUniversal(
//                                 tempListForSpecificDetail: StaticThings.homePagePopularGroundsData[index],
//                                 indexHero: index,
//                               );
//                             },
//                           ),
//                         );
//                       },
//                       child: Container(
//                         height: 180,
//                         decoration: BoxDecoration(
//                           // color: context.cardColor,
//                           // color: context.theme.scaffoldBackgroundColor,
//                           border: Border.all(
//                             color: context.theme.accentColor,
//                             // color: Colors.white70,
//                             width: 1,
//                           ),
//                           borderRadius: const BorderRadius.all(
//                             Radius.elliptical(10, 10),
//                           ),
//                         ),
//                         padding: const EdgeInsets.only(
//                           top: 10,
//                           left: 10,
//                           right: 10,
//                           // bottom: 10,
//                         ),
//                         child: Container(
//                           // color: Colors.black,
//                           height: 150,
//                           child: Column(
//                             // mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.elliptical(10, 10),
//                                   bottomRight: Radius.elliptical(10, 10),
//                                 ),
//                                 clipBehavior: Clip.antiAlias,
//                                 child: Image.network(
//                                     height: 100,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     'http://${MyRoutes.ip}/Capstone/manager_panel_3/${StaticThings.homePagePopularGroundsData[index]["image"]}'),
//                                 // child: Hero(
//                                 //   tag: 'item_$index', // Use the same unique tag as in the GridView.builder
//                                 //   child: Image.network(
//                                 //       height: 100,
//                                 //       width: double.infinity,
//                                 //       fit: BoxFit.cover,
//                                 //       'http://${MyRoutes.ip}/Capstone/manager_panel_3/${StaticThings.homePagePopularGroundsData[index]["image"]}'),
//                                 // ),
//                               ),
//                               SizedBox(
//                                 width: 250.0,
//                                 height: 25,
//                                 child: Center(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 5),
//                                     child: DefaultTextStyle(
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: context.accentColor,
//                                         shadows: [
//                                           Shadow(
//                                             blurRadius: 7.0,
//                                             color: context.accentColor,
//                                             offset: const Offset(0, 0),
//                                           ),
//                                         ],
//                                       ),
//                                       child: AnimatedTextKit(
//                                         repeatForever: true,
//                                         animatedTexts: [
//                                           FlickerAnimatedText('Lets Play'),
//                                           FlickerAnimatedText('Lets Book'),
//                                           FlickerAnimatedText("Lets Go"),
//                                         ],
//                                         onTap: () {
//                                           print("Tap Event");
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const Divider(
//                                 thickness: 1,
//                                 color: Colors.grey,
//                               ),
//                               Text(
//                                 StaticThings.homePagePopularGroundsData[index]["name"],
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   overflow: TextOverflow.ellipsis,
//                                   // color: Colors.black,
//                                   // color: context.theme.accentColor,
//                                   color: context.accentColor,
//                                   // fontSize: 25,
//                                   // fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const CircularProgressIndicator();
//             }
//           },
//         ),
//       ],
//     ),
  // Column(
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Container(
  //       // padding: Vx.m32,
  //       padding: Vx.mOnly(
  //         top: 32,
  //         left: 32,
  //         right: 32,
  //         // bottom: 20,
  //       ),
  //       child: SizedBox(
  //         height: 45,
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: <Widget>[
  //             // const Text(
  //             //   'Popular',
  //             //   style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
  //             // ),
  //             "High Rated".text.xl2.make(),

  //             DefaultTextStyle(
  //               style: const TextStyle(
  //                 fontSize: 20.0,
  //                 color: Colors.purple,
  //                 fontFamily: 'Bradley Hand ITC',
  //                 fontWeight: FontWeight.w500,
  //               ),
  //               child: AnimatedTextKit(
  //                 animatedTexts: [
  //                   RotateAnimatedText(' Grounds'),
  //                   RotateAnimatedText(' Bookings'),
  //                   // RotateAnimatedText(' '),
  //                 ],
  //                 onTap: () {
  //                   print("Tap Event");
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     GridView.builder(
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //       ),
  //       shrinkWrap: true,
  //       physics: const ClampingScrollPhysics(),
  //       itemCount: 4,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             height: 180,
  //             decoration: BoxDecoration(
  //               // color: context.cardColor,
  //               // color: context.theme.scaffoldBackgroundColor,
  //               border: Border.all(
  //                 color: context.theme.accentColor,
  //                 // color: Colors.white70,
  //                 width: 1,
  //               ),
  //               borderRadius: const BorderRadius.all(
  //                 Radius.elliptical(10, 10),
  //               ),
  //             ),
  //             padding: const EdgeInsets.only(
  //               top: 10,
  //               left: 10,
  //               right: 10,
  //               // bottom: 10,
  //             ),
  //             child: Container(
  //               // color: Colors.black,
  //               height: 150,
  //               child: Column(
  //                 // mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: const BorderRadius.only(
  //                       topLeft: Radius.elliptical(10, 10),
  //                       bottomRight: Radius.elliptical(10, 10),
  //                     ),
  //                     clipBehavior: Clip.antiAlias,
  //                     child: Image.network(
  //                         height: 100,
  //                         fit: BoxFit.fill,
  //                         'https://media.istockphoto.com/id/180868820/photo/cricket-batsman-about-to-strike-ball.jpg?s=612x612&w=0&k=20&c=xRiAIk3RA6cmm1FtI2S-YK8Pei9qSkqxhX-JUbTI2Cs='),
  //                   ),
  //                   SizedBox(
  //                     width: 250.0,
  //                     height: 25,
  //                     child: Center(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 5),
  //                         child: DefaultTextStyle(
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: context.accentColor,
  //                             shadows: [
  //                               Shadow(
  //                                 blurRadius: 7.0,
  //                                 color: context.accentColor,
  //                                 offset: const Offset(0, 0),
  //                               ),
  //                             ],
  //                           ),
  //                           child: AnimatedTextKit(
  //                             repeatForever: true,
  //                             animatedTexts: [
  //                               FlickerAnimatedText('Lets Play'),
  //                               FlickerAnimatedText('Lets Book'),
  //                               FlickerAnimatedText("Lets Go"),
  //                             ],
  //                             onTap: () {
  //                               print("Tap Event");
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   const Divider(
  //                     thickness: 1,
  //                     color: Colors.grey,
  //                   ),
  //                   const Text('Ground Name'),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   ],
  // ),

  //   // Widget 2
  //   // Container(
  //   //   child: Text('This is widget 2'),
  //   // ),
  // ];
}
