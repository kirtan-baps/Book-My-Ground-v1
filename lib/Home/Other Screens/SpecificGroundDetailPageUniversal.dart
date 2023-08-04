import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../../Widgets/chipWidget.dart';
import '../../utils/routes.dart';
import '../../utils/static_things.dart';
import '../BottomNavigationBarScreens/GroundScreenInterals/ZoomableImageFromCarausal.dart';
import 'BookingPart/Book1_SelectTimeDate.dart';
import 'dart:typed_data';

// ignore: must_be_immutable
class SpecificGroundDetailPageUniversal extends StatefulWidget {
  const SpecificGroundDetailPageUniversal({
    super.key,
    required this.tempListForSpecificDetail,
    required this.indexHero,
    required this.listTrans,
    // required this.indexExtra,
  });
  // int indexTransferForSpecificData = 0;
  // List tempListForSpecificDetail = [];
  final Map<String, dynamic> tempListForSpecificDetail;
  final int indexHero;
  // final int indexExtra;

  final List listTrans;

  @override
  State<SpecificGroundDetailPageUniversal> createState() => _SpecificGroundDetailPageUniversalState();
}

class _SpecificGroundDetailPageUniversalState extends State<SpecificGroundDetailPageUniversal> {
  List images = [];
  // ignore: non_constant_identifier_names
  Future view_image() async {
    try {
      var uri = Uri.http(
        MyRoutes.ip,
        '/Capstone/project_2/groundData/viewimages.php',
        {'q': '{http}'},
      );
      // var uri = Uri.http(MyRoutes.ip, '/flutter_app/viewimages.php', {'q': '{http}'});
      var response = await http.post(uri, body: {
        // "ground_id": widget.data[widget.i]["ground_id"],
        "ground_id": widget.tempListForSpecificDetail["ground_id"],
      });
      setState(() {
        images = json.decode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  // --------------------------------------
  // Features, Share, Call, Map

  bool favIconChange = true;

  // =================================================

  // final _phoneNumber = '+918849164661'; // Replace with the phone number you want to call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _requestPermissionAndMakeCall(String phoneNumber) async {
    if (await Permission.phone.request().isGranted) {
      // await _makePhoneCall();
      await _makePhoneCall(phoneNumber);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please grant phone permission to make a call')),
      );
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    try {
      await MapsLauncher.launchCoordinates(latitude, longitude);
    } catch (e) {
      throw 'Could not open the map.';
    }
  }

  // String shareText = 'Hello, check out this Pitch Cracker app! \nGround : '; // The text to share

  void _shareData() {
    // Share.share(shareText);
    Share.share("Hello, check out Pitch Cracker app! \nGround : ${widget.tempListForSpecificDetail['name']}");
  }

  // Future<void> _shareData() async {
  //   final bytes =
  //       await NetworkAssetBundle(Uri.parse('http://${MyRoutes.ip}/Capstone/manager_panel_3/${widget.tempListForSpecificDetail["image"]}')).load('');
  //   // await Share.shareFiles(
  //   //   ['${bytes.buffer.asUint8List()}'],
  //   //   text: "Hello, check out this Pitch Cracker app! \nGround : ${widget.tempListForSpecificDetail['name']}",
  //   //   // subject: 'Image Description',
  //   //   // mimeTypes: ['image/jpg'],
  //   // );
  //   await Share.shareFiles(
  //     ['${bytes.buffer.asUint8List()}'],
  //     text: "Hello, check out this Pitch Cracker app! \nGround : ${widget.tempListForSpecificDetail['name']}",
  //     subject: 'Image Description',
  //   );
  // }

  // =---==-=-=-=-=-=-==-=-=-=-=-=-=-=-
  // ManagerPhoneNumber
  // String phone = '';
  Future getManagerPhoneNumber() async {
    try {
      var uri = Uri.http(MyRoutes.ip, '/Capstone/project_2/ManagerData/managerPhoneNumber.php', {'q': '{http}'});
      var response = await http.post(uri, body: {
        "ground_id": widget.tempListForSpecificDetail["ground_id"],
      });
      setState(() {
        StaticThings.specificGroundManagerPhoneNumber = json.decode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  List mainReview = [];
  // ================
  Future getReview() async {
    try {
      var uri = Uri.http(MyRoutes.ip, '/Capstone/project_2/Reviews/getReview.php', {'q': '{http}'});
      print("Main ID ${widget.listTrans[widget.indexHero]["ground_id"]}");
      print(widget.tempListForSpecificDetail["ground_id"]);
      // print(widget.tempListForSpecificDetail[widget.indexHero]["ground_id"]);
      var response = await http.post(uri, body: {
        "ground_id": widget.listTrans[widget.indexHero]["ground_id"],
        // "ground_id": widget.tempListForSpecificDetail["ground_id"],
      });
      // StaticThings.groundPageReviewsData.clear();
      mainReview.clear();
      setState(() {
        mainReview = json.decode(response.body);
        // StaticThings.groundPageReviewsData = json.decode(response.body);
      });
    } catch (e) {
      print("Error is $e");
    }
  }

  TextEditingController reviewController = TextEditingController();
  // String userIdForReviewSPref = '';
  String id = '';

  Future getUsername() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        id = preferences.getString('id')!;
      });
    } catch (e) {
      print(e);
    }
  }

  Future addreview() async {
    try {
      var uri = Uri.http(MyRoutes.ip, '/Capstone/project_2/Reviews/addreview.php', {'q': '{http}'});
      var response = await http.post(uri, body: {
        // "ground_id": StaticThings.groundPageList[widget.indexHero]["ground_id"],
        "ground_id": widget.tempListForSpecificDetail["ground_id"],

        "user_id": id,
        "review": reviewController.text.toString(),
      });
      setState(() {
        reviewController.text = '';
        getReview();
      });
    } catch (e) {
      print(e);
    }
  }

  Future getTimeDataFunc() async {
    try {
      var uri = Uri.http(MyRoutes.ip, '/Capstone/project_2/groundData/booking.php', {'q': '{http}'});
      var response = await http.post(uri, body: {
        "ground_id": widget.tempListForSpecificDetail['ground_id'],
      });
      setState(() {
        StaticThings.groundPageSpecificTimeData = json.decode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    view_image();
    getManagerPhoneNumber();

    // -----------
    getUsername();
    getReview();
    getTimeDataFunc();

    //
    // debugPrint(widget.tempListForSpecificDetail['latitude']);
    // debugPrint(widget.tempListForSpecificDetail['longitude']);

    // double? tempData = double.tryParse(widget.tempListForSpecificDetail['latitude']);
    // debugPrint(tempData.runtimeType as String?);

    // debugPrint(widget.tempListForSpecificDetail['longitude']);
  }

  @override
  Widget build(BuildContext context) {
    // --------------------------
    // Book Button Animation
    const colorizeColors = [
      Colors.grey,
      Colors.black,
    ];

    const colorizeTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      fontFamily: 'Horizon',
      color: Colors.black,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.canvasColor,
          iconTheme: IconThemeData(color: context.accentColor),
          elevation: 0,
          title: Hero(
            tag: 'item_${widget.indexHero}', // Use the same unique tag as in the GridView.builder
            child: Text(
              "${widget.tempListForSpecificDetail['name']}",
              style: TextStyle(color: context.accentColor),
            ),
          ),
          // title: ScaleTransition(
          //   scale: Tween<double>(begin: 0.0, end: 1.0).animate(
          //     CurvedAnimation(
          //       parent: ModalRoute.of(context)!.animation!,
          //       curve: Curves.easeInOut,
          //     ),
          //   ),
          //   child: Text(
          //     'Hello, World!',
          //     style: TextStyle(fontSize: 64.0),
          //   ),
          // ),
        ),

        // backgroundColor: context.canvasColor,
        backgroundColor: context.theme.scaffoldBackgroundColor,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                // dynamic mainUrl = "http://${MyRoutes.ip}/Capstone/manager_panel_3/${images[index]["image"]}";

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ZoomableImage(
                              imageUrl: images[index]["image"],
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'itemm_$index', // Use the same unique tag as in the GridView.builder

                        child: Image.network(
                          // images[index],
                          'http://${MyRoutes.ip}/Capstone/manager_panel_3/${images[index]["image"]}',
                          // mainUrl,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: _currentIndex,
                enableInfiniteScroll: false,
                onPageChanged: (index, _) {
                  try {
                    setState(() {
                      _currentIndex = index;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _currentIndex > 0
                      ? () {
                          _controller.previousPage();
                          setState(() {
                            _currentIndex--;
                          });
                        }
                      : null,
                ),
                Text(
                  '${_currentIndex + 1}/${images.length}',
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _currentIndex < images.length - 1
                      ? () {
                          _controller.nextPage();
                          setState(() {
                            _currentIndex++;
                          });
                        }
                      : null,
                ),
              ],
            ),
            // Hero(
            //   // tag: Key(tempListForSpecificDetail['id'].toString()),
            //   tag: 'item_${widget.indexHero}', // Use the same unique tag as in the GridView.builder
            //   child: Image.network(
            //     // "http://10.0.2.2/Flutter/image_and_text_upload_fetch2/${widget.ground_Data_T["image"]}",
            //     // "http://${MyRoutes.ip}/Flutter/image_and_text_upload_fetch2/${widget.ground_Data_T["image"]}",
            //     // 'http://${MyRoutes.ip}/Capstone/manager_panel_2/${tempListForSpecificDetail["image"]}',
            //     'http://${MyRoutes.ip}/Capstone/manager_panel_3/${widget.tempListForSpecificDetail["image"]}',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // Center(
            //   child: Text(
            //     "${widget.tempListForSpecificDetail['ground_id']}",
            //     style: const TextStyle(
            //       color: Colors.blue,
            //       fontSize: 50,
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Text(
            //     "${widget.tempListForSpecificDetail['name']}",
            //     style: TextStyle(
            //       color: context.accentColor,
            //       fontSize: 50,
            //     ),
            //   ),
            // ),
            // Image.network(
            //   'http://${MyRoutes.ip}/Capstone/manager_panel_3/${widget.tempListForSpecificDetail["image"]}',
            //   fit: BoxFit.cover,
            // ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const ClampingScrollPhysics(),
            //   itemCount: images.length,
            //   itemBuilder: (context, index) {
            //     return Image.network(
            //       'http://${MyRoutes.ip}/Capstone/manager_panel_3/${images[index]["image"]}',
            //       fit: BoxFit.cover,
            //     );
            //   },
            // ),

            Expanded(
              child: VxArc(
                height: 30.0,
                // arcType: VxArcType.CONVEY,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  width: context.screenWidth,
                  color: context.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // widget.tempListForSpecificDetail['name'].bold.lg.color(context.accentColor).xl4.make(),
                          // catalog.desc.text.textStyle(context.captionStyle).xl.make(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: Text(
                                widget.tempListForSpecificDetail['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.accentColor,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          10.heightBox,
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 27,
                            ),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                // onPressed: () => _requestPermissionAndMakeCall('+918849164661'),
                                onPressed: () => _requestPermissionAndMakeCall(StaticThings.specificGroundManagerPhoneNumber),
                                icon: const Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                // onPressed: _openMapLink,
                                // onPressed: () => navigateTo(37.7749, -122.4194),
                                // onPressed: () => openMap(37.7749, -122.4194),
                                onPressed: () => openMap(double.parse(widget.tempListForSpecificDetail['latitude']),
                                    double.parse(widget.tempListForSpecificDetail['longitude'])),
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.yellow,
                                ),
                              ),
                              IconButton(
                                onPressed: _shareData,
                                icon: const Icon(
                                  Icons.share,
                                  // color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Pitch Available",
                              style: TextStyle(
                                color: context.accentColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChipForTennisBall(widget: widget),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChipForMatcisBall(widget: widget),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Address: ',
                                    style: TextStyle(
                                      color: context.accentColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${widget.tempListForSpecificDetail['address']},${widget.tempListForSpecificDetail['city']}',
                                    style: TextStyle(
                                      color: context.accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 27,
                            ),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Center(
                            child: Text(
                              "About",
                              style: TextStyle(
                                color: context.accentColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          "Cillum in adipisicing labore aliquip Lorem aute cillum non consectetur. Veniam exercitation duis Lorem ad esse esse exercitation exercitation esse magna esse."
                              .text
                              .textStyle(context.captionStyle)
                              .make()
                              .p16(),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 27,
                            ),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Reviews",
                              style: TextStyle(
                                color: context.accentColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // StaticThings.groundPageReviewsData.isNotEmpty
                          mainReview.isNotEmpty
                              ? FutureBuilder(
                                  future: getReview(),
                                  builder: (context, snapshot) {
                                    return ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: mainReview.length,
                                      // itemCount: 4,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 5,
                                            shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(10, 20))),
                                            shadowColor: context.accentColor,
                                            color: context.cardColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: ListTile(
                                                // title: Text("Name:  ${StaticThings.groundPageReviewsData[index]['username']}"),
                                                // title: Text("Name:  ${mainReview[index]['username']}"),
                                                title: ReadMoreText(
                                                  // "Name: ${StaticThings.groundPageReviewsData[index]['firstname']}",
                                                  "Name: ${mainReview[index]['firstname']}",
                                                  trimLines: 2,
                                                  colorClickableText: Colors.pink,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText: 'Show more',
                                                  trimExpandedText: 'Show less',
                                                ),
                                                // subtitle: Text("Name:  ${mainReview[index]['review']}"),
                                                subtitle: ReadMoreText(
                                                  // "Review: ${StaticThings.groundPageReviewsData[index]['review']}",
                                                  "Review: ${mainReview[index]['review']}",
                                                  trimLines: 2,
                                                  colorClickableText: context.backgroundColor,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText: 'Show more',
                                                  trimExpandedText: 'Show less',
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              : const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  child: Center(
                                    child: Text("No Reviews Yet"),
                                  ),
                                ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 27,
                            ),
                            child: Divider(
                              thickness: 5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Add Review",
                              style: TextStyle(
                                color: context.accentColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: reviewController,
                                    decoration: const InputDecoration(
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(),
                                      labelText: "Enter your review",
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => addreview(),
                                icon: const Icon(Icons.send_sharp),
                              ),
                            ],
                          ),
                        ],
                      ).py64(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.grey,
          child: SizedBox(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.tempListForSpecificDetail['price'] == null ? '\$99.99' : "₹ ${widget.tempListForSpecificDetail['price']}/hr",
                        style: const TextStyle(
                          // color: Colors.white,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Perform buy action here
                    // print("Choose Timew");
                    // debugPrint("lol");
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "content".text.make()));
                    // ================

                    // ================
                    // String ground_id = widget.ground_Data_T['ground_id'].toString();
                    // String price_id = widget.ground_Data_T['pid'].toString();
                    // String price = widget.ground_Data_T['price'].toString();
                    // String manager_id = widget.ground_Data_T['manager_id'].toString();

                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return Ground_Book_Page(ground_id, price_id, price, manager_id);
                    //   },
                    // ));
                  },
                  child: Container(
                    height: 50.0,
                    width: 100.0,
                    color: Colors.grey[300],
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "content".text.make()));
                        },
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              // speed: ,
                              'Book',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                            ),
                            ColorizeAnimatedText(
                              'Book',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                            ),
                            ColorizeAnimatedText(
                              'Book',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                            ),
                          ],
                          isRepeatingAnimation: true,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Book1SelectTimeDate(
                                  tempListForSpecificDetailTranfered: widget.tempListForSpecificDetail,
                                  indexTrans: widget.indexHero,
                                );
                              },
                            ));
                          },
                        ),
                      ),
                    ),
                  ),
                  // child: Container(
                  //   height: 50.0,
                  //   width: 100.0,
                  //   color: Colors.grey[300],
                  //   child: const Center(
                  //     child: Text(
                  //       'Book',
                  //       style: TextStyle(
                  //         color: Colors.blue,
                  //         fontSize: 26.0,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
