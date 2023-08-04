// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../ThemeData/theme.dart';
import '../../utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/static_things.dart';
import 'GroundScreenInterals/SpecificGroundDetailPage.dart';
import '../Other Screens/SpecificGroundDetailPageUniversal.dart';
import 'HomeScreenInterals/HomeScreenFeedbacks.dart';
import 'HomeScreenInterals/HomeScreenHeader.dart';
import 'HomeScreenInterals/HomeScreenPopularGrounds.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List groundSliderImageList = [];
  Future<String> groundSliderImageFunc() async {
    try {
      var response = await http.post(
        Uri.http(
          MyRoutes.ip,
          // '/Capstone/project_2/groundData/ground_list_ForSlider.php',
          '/Capstone/project_2/groundData/ground_list_ForSlider_with_price_pitch.php',
          {'q': '{http}'},
        ),
      );

      setState(() {
        // groundSliderImageList = json.decode(response.body);
        StaticThings.sliderData = json.decode(response.body);
      });
    } catch (e) {
      print(e);
    }
    // ===============
    // ===============
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    groundSliderImageFunc();
  }

  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  // @override
  // void dispose() {
  //   groundSliderImageFunc();
  //   HomeScreenSlider(context);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeScreenHeader(
              nameText: 'Ground Booking App',
            ),
            HomeScreenSlider(context),
            const HomeScreenPopularGrounds(),

            // ========================
            // const HomeScreenFeedbacks(),

            // const TempDevamWidget(),
          ],
        ),
      ),
    );
  }

  // -----------
  // HomeScreenSlider
  // -----------
  // ignore: non_constant_identifier_names
  Column HomeScreenSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: Vx.mOnly(bottom: 15, left: 32, right: 32),
          child: "Trending Grounds".text.xl2.make(),
        ),
        SizedBox(
          height: 250,
          width: 500,
          child: Stack(
            children: [
              // groundSliderImageList.isEmpty
              StaticThings.sliderData.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(108.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CarouselSlider.builder(
                      // itemCount: groundSliderImageList.length,
                      itemCount: StaticThings.sliderData.length,
                      carouselController: carouselController,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            // debugPrint(currentIndex.toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SpecificGroundDetailPageUniversal(
                                    tempListForSpecificDetail: StaticThings.sliderData[index],
                                    indexHero: index,
                                    listTrans: StaticThings.sliderData,
                                  );
                                },
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            // fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  // groundSliderImageList[index]['image_url'],
                                  // 'http://${MyRoutes.ip}/Flutter/image_and_text_upload_fetch2/${groundSliderImageList[index]["image"]}',
                                  // 'http://${MyRoutes.ip}/Capstone/manager_panel_2/${groundSliderImageList[index]["image"]}',
                                  // =========
                                  // 'http://${MyRoutes.ip}/Capstone/manager_panel_2/${StaticThings.sliderData[index]["image"]}',
                                  'http://${MyRoutes.ip}/Capstone/manager_panel_3/${StaticThings.sliderData[index]["image"]}',
                                  width: 1050,
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.elliptical(20, 20), bottomRight: Radius.elliptical(20, 20)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.2),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Container(
                                        height: 50,
                                        width: 250,
                                        color: Colors.grey.withOpacity(0.4),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                            child: Text(
                                              // groundSliderImageList[index]["name"],
                                              StaticThings.sliderData[index]["name"],
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                // overflow: TextOverflow.clip,
                                                // color: Colors.black,
                                                // color: context.theme.accentColor,
                                                // color: context.accentColor,
                                                color: MyTheme.creamColor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // itemBuilder: (BuildContext context, int index) {
                      //   return Image.network(groundSliderImageList[index]['image_url']);
                      // },
                    ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // children: groundSliderImageList.asMap().entries.map(
                  children: StaticThings.sliderData.asMap().entries.map(
                    (entry) {
                      // print(entry);
                      // print(entry.key);
                      return GestureDetector(
                        onTap: () => carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: currentIndex == entry.key ? Colors.grey : Colors.black,
                            color: currentIndex == entry.key ? context.accentColor : context.accentColor,
                          ),
                          // ? Colors.red
                          // : Colors.teal),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TempDevamWidget extends StatelessWidget {
  const TempDevamWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Vx.mOnly(
                  left: 32,
                  top: 10,
                  bottom: 10,
                ),
                child: SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Popular',
                        style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                      ),
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
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 156, 148, 148).withOpacity(0.5),
                        width: 0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 146 / 136,
                            child: InkWell(
                              onTap: () {
                                print("LOL");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), offset: Offset(0, 10), spreadRadius: 0, blurRadius: 15)
                                  ],
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://media.istockphoto.com/id/180868820/photo/cricket-batsman-about-to-strike-ball.jpg?s=612x612&w=0&k=20&c=xRiAIk3RA6cmm1FtI2S-YK8Pei9qSkqxhX-JUbTI2Cs='),
                                      // image: AssetImage(
                                      //   "assets/images/state.jpg",
                                      // ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 8,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: const [
                          //     Text(
                          //       'Last:',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 12,
                          //         color: Color(0xffA9ADB7),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                            height: 0,
                            thickness: 1,
                            color: Color.fromARGB(255, 195, 185, 185),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Last:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xffA9ADB7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 156, 148, 148).withOpacity(0.5),
                        width: 0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 146 / 136,
                            child: InkWell(
                              onTap: () {
                                print("LOL");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), offset: Offset(0, 10), spreadRadius: 0, blurRadius: 15)
                                  ],
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://media.istockphoto.com/id/180868820/photo/cricket-batsman-about-to-strike-ball.jpg?s=612x612&w=0&k=20&c=xRiAIk3RA6cmm1FtI2S-YK8Pei9qSkqxhX-JUbTI2Cs='),
                                      // image: AssetImage(
                                      //   "assets/images/state.jpg",
                                      // ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                            height: 0,
                            thickness: 1,
                            color: Color.fromARGB(255, 195, 185, 185),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            width: 250.0,
                            height: 26,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    blurRadius: 7.0,
                                    color: Colors.black,
                                    offset: Offset(0, 0),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
