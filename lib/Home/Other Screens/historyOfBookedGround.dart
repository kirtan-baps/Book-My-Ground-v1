import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp4/Home/BottomNavigationBarScreens/HomeScreenInterals/HomeScreenHeader.dart';
import 'package:myapp4/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../../utils/static_things.dart';

class HistoryOfBookedGround extends StatefulWidget {
  const HistoryOfBookedGround({super.key});

  @override
  State<HistoryOfBookedGround> createState() => _HistoryOfBookedGroundState();
}

class _HistoryOfBookedGroundState extends State<HistoryOfBookedGround> {
  String id = '';
  Future getdata() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        id = preferences.getString('id')!;
      });
      var uri = Uri.http(MyRoutes.ip, '/Capstone/project_2/groundData/historyOfBookedGround.php', {'q': '{http}'});
      print(uri);
      print(id.toString());
      var response = await http.post(uri, body: {
        "id": id.toString(),
      });
      setState(() {
        StaticThings.groundBookedUserHistoryList = json.decode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
    // getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 30),
                  child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
                ),
                HomeScreenHeader(
                  nameText: 'Booking History',
                ),
              ],
            ),
            StaticThings.groundBookedUserHistoryList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: StaticThings.groundBookedUserHistoryList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 20,
                          child: ListTile(
                            // tileColor: index.isOdd ? Colors.grey[200] : context.cardColor,
                            leading: CircleAvatar(child: Text(StaticThings.groundBookedUserHistoryList[index]['name'].substring(0, 1))),
                            title: Text(
                              StaticThings.groundBookedUserHistoryList[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                    "Date: ${StaticThings.groundBookedUserHistoryList[index]['date']}\nTimings: ${StaticThings.groundBookedUserHistoryList[index]['time']} "),
                                // Text(StaticThings.groundBookedUserHistoryList[index]['time'])
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(100.0),
                    child: Center(
                        child: Text(
                      "You have no Bookings yet",
                    )),
                  ),
          ],
        ),
      ),
    );
  }
}




// class history extends StatefulWidget {
//   //const history({Key? key}) : super(key: key);
//   List History=[];
//   @override
//   State<history> createState() => _historyState();
// }

// class _historyState extends State<history> {
//   String id='';


//   Future getdata() async {
//     SharedPreferences preferences=await SharedPreferences.getInstance();
//     setState(() {
//       id=preferences.getString('id')!;
//     });
//     var uri = Uri.http("192.168.51.11", '/flutter_app/history.php', {'q': '{http}'});
//     var response = await http.post(uri, body: {
//       "id":id.toString(),
//     });
//     setState(() {
//       widget.History = json.decode(response.body);
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     getdata();
//     //getUsername();
//   }
//   @override
//   Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text("History"),),
    //   body:  ListView.builder(itemCount: widget.History.length,itemBuilder: (context, index) {
    //       return ListTile(
    //         title: Text(widget.History[index]['name']),
    //         subtitle: Row(
    //           children: [
    //             Text(widget.History[index]['date']),
    //             Text(widget.History[index]['time'])
    //           ],
    //         ),

    //       );
    //     },),

    // );
//   }
// }