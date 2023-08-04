import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/routes.dart';
import '../../../utils/static_things.dart';
import '../../Other Screens/SpecificGroundDetailPageUniversal.dart';
// GroundSearchSuggestor

class CustomSearchDelegate extends SearchDelegate {
  // List<dynamic> ground_Data_For_Search = [];

  // CustomSearchDelegate(
  //   this.ground_Data_For_Search,
  // );

  // List matchQuery = StaticThings.groundPageList.where((element) => element['name'].toLowerCase().contains(query.toLowerCase())).toList();

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var grounds in StaticThings.groundPageList) {
      if (grounds['name'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(grounds);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return matchQuery.isNotEmpty
              ? InkWell(
                  onTap: () {
                    print(index);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       // return SpecificObjectDetail(ground_Data_T: StaticThings.groundPageList[index]);
                    //       return SpecificObjectDetail(
                    //         indexTransferForSpecificData: index,
                    //       );
                    //     },
                    //   ),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SpecificGroundDetailPageUniversal(
                            tempListForSpecificDetail: matchQuery[index],
                            indexHero: index,
                            listTrans: matchQuery,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 400, // set the desired height of the container
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          // 'http://${MyRoutes.ip}/Capstone/manager_panel_2/${StaticThings.groundPageList[index]["image"]}',
                          'http://${MyRoutes.ip}/Capstone/manager_panel_3/${StaticThings.groundPageList[index]["image"]}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, // set the bottom position of the container to half outside the image
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 2.0,
                                  ),
                                ),
                                // color: Colors.black.withOpacity(0.7),
                                child: Center(
                                  // child: Text(
                                  //   matchQuery[index]['name'],
                                  //   style: const TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 18,
                                  //   ),
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 13),
                                    child: Text(
                                      matchQuery[index]["name"].length > 10
                                          ? '${matchQuery[index]["name"].substring(0, 15)}...'
                                          : matchQuery[index]["name"],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15,
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
                  ),
                )
              : const CircularProgressIndicator(
                  color: Colors.black,
                );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          // childAspectRatio: 2.5,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List _recentSearches = [];
    List matchQuery = [];
    for (var grounds in StaticThings.groundPageList) {
      if (grounds['name'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(grounds);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (BuildContext context, int index) {
        return matchQuery.isNotEmpty
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SpecificGroundDetailPageUniversal(
                          tempListForSpecificDetail: matchQuery[index],
                          indexHero: index,
                          listTrans: matchQuery,
                        );
                      },
                    ),
                  );
                },
                child: ListTile(
                  // leading: Image.memory(base64Decode(results[index]['imageData'])),
                  title: Text(matchQuery[index]['name']),
                ),
              )
            : const CircularProgressIndicator(
                color: Colors.black,
              );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        close(context, null);
      },
    );
  }
}
