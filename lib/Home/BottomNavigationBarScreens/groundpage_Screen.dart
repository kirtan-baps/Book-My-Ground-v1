import 'dart:convert';

import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../OtherScreens/LoadingWidgetOfGroundScreen.dart';
import '../../utils/routes.dart';
import '../../utils/static_things.dart';
import 'GroundScreenInterals/AllGroundsOfGroundPage.dart';
import 'GroundScreenInterals/GroundSearchSuggestor.dart';
import 'GroundScreenInterals/SpecificGroundDetailPage.dart';
import '../Other Screens/SpecificGroundDetailPageUniversal.dart';
import 'HomeScreenInterals/HomeScreenHeader.dart';

class GroundPage extends StatefulWidget {
  const GroundPage({super.key});

  @override
  State<GroundPage> createState() => _GroundPageState();
}

class _GroundPageState extends State<GroundPage> {
  // List ground_Data = [];

  List distance_temp_ground_Data = [];

  Future<String> getGroundData() async {
    try {
      var response = await http.post(
        Uri.http(
          // "10.0.2.2",
          MyRoutes.ip,
          '/Capstone/project_2/groundData/ground_list_MainDB_with_price_pitch.php',
          {'q': '{http}'},
        ),
      );
      StaticThings.groundPageList = json.decode(response.body);
    } catch (e) {
      print(e);
    }
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    getGroundData();
    _getTheDistanceFromAPI();
  }

  Position? _currentUserPosition;

  double? distanceImMeter = 0.0;

  Future _getTheDistanceFromAPI() async {
    try {
      // Check if location permission is granted
      var status = await Permission.locationWhenInUse.status;
      if (status.isGranted) {
        // Location permission granted, perform function that requires location
        // access here
        _currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        for (int i = 0; i < StaticThings.groundPageList.length; i++) {
          double storelat = double.parse(StaticThings.groundPageList[i]["latitude"].replaceAll(RegExp('[^0-9\.]'), ''));
          double storelng = double.parse(StaticThings.groundPageList[i]["longitude"].replaceAll(RegExp('[^0-9\.]'), ''));
          // double storelat = StaticThings.groundPageList[i]['latitude'];
          // double storelng = StaticThings.groundPageList[i]['longitude'];

          distanceImMeter = Geolocator.distanceBetween(
            _currentUserPosition!.latitude,
            _currentUserPosition!.longitude,
            storelat,
            storelng,
          );
          final int? distance = distanceImMeter?.round().toInt();

          // StaticThings.groundPageList[i]['distance'] = (distance! / 100);

          StaticThings.groundPageList[i]["distance"] = (distance! / 100);
          setState(() {});
          distance_temp_ground_Data.add(StaticThings.groundPageList[i]["distance"]);
          // int tempDistance = int.parse(StaticThings.groundPageList[i]['distance']);
        }
      } else {
        // Request location permission
        if (await Permission.locationWhenInUse.request().isGranted) {
          // Location permission granted, perform function that requires location
          // access here
        } else {
          // Location permission not granted, handle error here
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "Location Permission Not Provided".text.make()));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _getTheDistanceFromAPI();
  //   getGroundData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeScreenHeader(
                    nameText: 'GroundPage',
                  ),
                  Container(
                    padding: Vx.mOnly(
                      top: 38,
                      left: 32,
                      right: 10,
                      bottom: 10,
                    ),
                    child: IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: CustomSearchDelegate());
                      },
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: context.accentColor,
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: getGroundData(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return AllGroundsOfGroundPage(distance_temp_ground_Data: distance_temp_ground_Data);
                  } else {
                    // return const Center(
                    //   child: CircularProgressIndicator(
                    //     backgroundColor: Colors.grey,
                    //     color: Colors.black,
                    //   ),
                    // );
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          LoadingWidgetOfGroundScreen(),
                          LoadingWidgetOfGroundScreen(),
                          LoadingWidgetOfGroundScreen(),
                          LoadingWidgetOfGroundScreen(),
                        ],
                      ),
                    );
                  }
                },
              ),
              // Container(
              //   width: 125,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: const Color(0xffF6F6F6),
              //       width: 1.5,
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         'assets/images/secureEmail.jpg',
              //         height: 100,
              //         width: 100,
              //         fit: BoxFit.fitWidth,
              //       ),
              //       const SizedBox(
              //         height: 14,
              //       ),
              //       const Text(
              //         "Echreza",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 14,
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 8,
              //       ),
              //       const Text(
              //         "2.822 MATIC",
              //         style: TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w500,
              //           color: Color(0xff25D76C),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
