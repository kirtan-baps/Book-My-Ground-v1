import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/routes.dart';
import '../../../utils/static_things.dart';
import '../../Other Screens/SpecificGroundDetailPageUniversal.dart';

class AllGroundsOfGroundPage extends StatelessWidget {
  const AllGroundsOfGroundPage({
    super.key,
    required this.distance_temp_ground_Data,
  });

  final List distance_temp_ground_Data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: StaticThings.groundPageList == null ? 0 : StaticThings.groundPageList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print(index);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       // return SpecificObjectDetail(ground_Data_T: StaticThings.groundPageList[index]);
            //       return SpecificObjectDetail(indexTransferForSpecificData: index);
            //     },
            //   ),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SpecificGroundDetailPageUniversal(
                    tempListForSpecificDetail: StaticThings.groundPageList[index],
                    indexHero: index,
                    listTrans: StaticThings.groundPageList,
                  );
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                          // 'http://${MyRoutes.ip}/Capstone/manager_panel_2/${StaticThings.groundPageList[index]["image"]}',
                          'http://${MyRoutes.ip}/Capstone/manager_panel_3/${StaticThings.groundPageList[index]["image"]}',
                          fit: BoxFit.cover,
                          height: 225,
                        ).box.rounded.p16.color(context.canvasColor).make().p16().wFull(context),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  // Hero(
                                  //   tag: 'item_$index',
                                  //   child: Text(
                                  //     StaticThings.groundPageList[index]["name"].length > 15
                                  //         ? '${StaticThings.groundPageList[index]["name"].replaceAll('_', ' ').substring(0, 15)}...'
                                  //         : StaticThings.groundPageList[index]["name"],
                                  //     overflow: TextOverflow.ellipsis,
                                  //     maxLines: 1,
                                  //     style: TextStyle(fontWeight: FontWeight.bold, color: context.accentColor, fontSize: 20),
                                  //   ),
                                  // ),
                                  Text(
                                    StaticThings.groundPageList[index]["name"].length > 15
                                        ? '${StaticThings.groundPageList[index]["name"].substring(0, 15)}...'
                                        : StaticThings.groundPageList[index]["name"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: context.accentColor, fontSize: 20),
                                  ),
                                  Text(
                                    StaticThings.groundPageList[index]["address"].length > 15
                                        ? '${StaticThings.groundPageList[index]["address"].substring(0, 15)}...'
                                        : StaticThings.groundPageList[index]["address"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: context.accentColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              distance_temp_ground_Data.isNotEmpty
                                  ? Text(
                                      "${NumberFormat.compact().format(distance_temp_ground_Data[index].round())}  KM",

                                      // "${distance_temp_ground_Data[index].round()}  KM",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: context.accentColor, fontSize: 20),
                                    )
                                  // : const Padding(
                                  //     padding: EdgeInsets.all(12.0),
                                  //     child: CircularProgressIndicator(
                                  //       color: Colors.white,
                                  //       semanticsLabel: "LOL",
                                  //       strokeWidth: 4,
                                  //       backgroundColor: Colors.grey,
                                  //     ),
                                  //   )
                                  // : PouringHourGlassRefined(
                                  //     itemBuilder: (BuildContext context, int index) {
                                  //       return DecoratedBox(
                                  //         decoration: BoxDecoration(
                                  //           color: index.isEven ? Colors.red : Colors.green,
                                  //         ),
                                  //       );
                                  //     },
                                  //   )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: SpinKitDoubleBounce(
                                          color: context.accentColor,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
