import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myapp4/OtherScreens/editProfile.dart';
import 'package:myapp4/Widgets/toast.dart';
import 'package:myapp4/utils/routes.dart';
import 'package:pay/pay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/static_things.dart';
import '../../../utils/static_things.dart';

class Book1SelectTimeDate extends StatefulWidget {
  const Book1SelectTimeDate({super.key, required this.tempListForSpecificDetailTranfered, required this.indexTrans});
  final int indexTrans;
  final Map<String, dynamic> tempListForSpecificDetailTranfered;
  // final String ground_id="";
  // final String price_id="";
  // final String price="";
  // final String manager_id='';

  // late String selectedValue =data[0];

  @override
  State<Book1SelectTimeDate> createState() => _Book1SelectTimeDateState();
}

class _Book1SelectTimeDateState extends State<Book1SelectTimeDate> {
  late DateTime selectedDate;
  // DateTime selectedDate = DateTime.now();
  String selectedValue = StaticThings.groundPageSpecificTimeData[0];

  String id = '';

  Future bookGround() async {
    String date = selectedDate.toString();
    // dynamic date = selectedDate.toString();
    date = date.substring(0, 10);
    print(widget.tempListForSpecificDetailTranfered['pid']);
    print(widget.tempListForSpecificDetailTranfered['manager_id']);
    var uri = Uri.http(MyRoutes.ip, '/Capstone/project_2/groundData/booked.php', {'q': '{http}'});
    var response = await http.post(uri, body: {
      "time": selectedValue,
      "date": date,
      "user_id": id,
      "price_id": widget.tempListForSpecificDetailTranfered['pid'],
      "manager_id": widget.tempListForSpecificDetailTranfered['manager_id'],
    });
    var book = json.decode(response.body);

    // var book = "Error";
    // var book = "lol";

    if (book.toString() == "Error") {
      ToastsClass.regularToast('Already Booked');
      // Fluttertoast.showToast(
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   msg: 'Already book',
      //   toastLength: Toast.LENGTH_SHORT,
      // );

      // /Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home(widget.id)));/
    } else {
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return home();
      //   },
      // ));
      // ignore: use_build_context_synchronously
      showModalBottomSheet(
        isDismissible: true,
        enableDrag: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset(
                          'assets/gif/BookedGIf.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "You have Successfully Booked ${widget.tempListForSpecificDetailTranfered["name"]}.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.accentColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ConstrainedBox(
                        //   constraints: const BoxConstraints.tightFor(width: 150, height: 80),
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         primary: context.accentColor, //background color of button
                        //         side: BorderSide(width: 3, color: context.backgroundColor), //border width and color
                        //         elevation: 3, //elevation of button
                        //         shape: RoundedRectangleBorder(
                        //             //to set border radius to button
                        //             borderRadius: BorderRadius.circular(30)),
                        //         padding: const EdgeInsets.all(20) //content padding inside button
                        //         ),
                        //     onPressed: () {
                        //       Navigator.pushNamedAndRemoveUntil(context, MyRoutes.historyPageRoute, (route) => false);

                        //       // Navigator.
                        //     },
                        //     child: "History".text.make(),
                        //   ),
                        // ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(width: 150, height: 80),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: context.accentColor, //background color of button
                                side: BorderSide(width: 3, color: context.backgroundColor), //border width and color
                                elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.all(20) //content padding inside button
                                ),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
                            },
                            // child: "Close".text.textStyle(context.accentColor).make(),
                            child: Text(
                              "Close",
                              style: TextStyle(color: context.canvasColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
      // Future.delayed(
      //   const Duration(
      //     seconds: 4,
      //   ),
      //   () {
      //     // Navigator.restorablePushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
      //     Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
      //   },
      // );
    }
  }

  Future getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('id')!;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime.now(), lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(DateFormat('yyyy-MM-dd').format(selectedDate));
      });
    }
  }

  // late bool isloading;
  @override
  void initState() {
    super.initState();
    getUsername();
    // book();
    print(selectedValue);
    selectedDate = DateTime.now();
    paymentTotalFunction();
  }

  TextEditingController dateInput = TextEditingController();
  final _paymentItems = <PaymentItem>[];

  paymentTotalFunction() {
    _paymentItems.add(PaymentItem(
      // amount: _cart.totalPrice.toString(),
      amount: widget.tempListForSpecificDetailTranfered["price"].toString(),
      label: "MSM Payment",
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Column(
              children: [
                // Image.network(
                //   'http://${MyRoutes.ip}/Capstone/manager_panel_2/${StaticThings.groundPageList[index]["image"]}',
                // ).box.rounded.p16.color(context.canvasColor).make().p16().wFull(context),
                Card(
                  shadowColor: context.theme.canvasColor,
                  elevation: 18,
                  shape: const BeveledRectangleBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(10),
                      // topRight: Radius.circular(10),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  semanticContainer: true,
                  color: context.cardColor,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    color: context.cardColor,
                    child: Column(
                      children: [
                        Image.network(
                          'http://${MyRoutes.ip}/Capstone/manager_panel_3/${widget.tempListForSpecificDetailTranfered["image"]}',
                          fit: BoxFit.cover,
                          height: 225,
                        ).box.rounded.p16.color(context.canvasColor).make().p16().wFull(context),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                widget.tempListForSpecificDetailTranfered["name"].length > 20
                                    ? '${widget.tempListForSpecificDetailTranfered["name"].substring(0, 20)}...'
                                    : widget.tempListForSpecificDetailTranfered["name"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.accentColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  width: context.screenWidth,
                  color: context.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                            ),
                            child: "Select Date".text.xl.make(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Divider(
                              color: context.accentColor,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () => _selectDate(context),
                                child: Text(
                                  DateFormat('dd-MM-yyyy').format(selectedDate),
                                  // style: Theme.of(context).textTheme.headlineMedium,
                                  style: TextStyle(color: context.accentColor, fontSize: 30),
                                ),
                              ),
                              // ElevatedButton(
                              //   onPressed: () => _selectDate(context),
                              //   child: const Text('Pick Date'),
                              // ),
                              IconButton(
                                onPressed: () => _selectDate(context),
                                icon: const Icon(Icons.date_range_sharp),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: "Select Time".text.xl.make(),
                          ),
                          Divider(
                            color: context.accentColor,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: DropdownButton<String>(
                                underline: Container(),
                                alignment: Alignment.center,

                                // focusColor: context.accentColor,
                                // dropdownColor: context.accentColor,
                                style: TextStyle(color: context.accentColor, fontSize: 25),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                items: StaticThings.groundPageSpecificTimeData.map((value) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       bookGround();
                          //     },
                          //     child: Text("book")),
                          InkWell(
                            onTap: () => bookGround(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Confirm Booking",
                                  style: TextStyle(fontSize: 15, color: context.accentColor),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(Icons.payments)
                              ],
                            ),
                          )
                        ],
                      ),
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
            height: 80.0,
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
                        widget.tempListForSpecificDetailTranfered['price'] == null
                            ? '\$99.99'
                            : "₹ ${widget.tempListForSpecificDetailTranfered['price']}/hr",
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
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 18,
                      right: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ApplePayButton(
                          paymentConfigurationAsset: 'applepay.json',
                          // paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePayConfigString),
                          paymentItems: _paymentItems,
                          style: ApplePayButtonStyle.black,
                          type: ApplePayButtonType.buy,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: (result) {
                            print(result);
                          },
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        GooglePayButton(
                          // paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePayConfigString),
                          paymentConfigurationAsset: "gpay.json",
                          paymentItems: _paymentItems,
                          width: 180,
                          type: GooglePayButtonType.pay,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: (result) {
                            print(result);
                          },
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
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
