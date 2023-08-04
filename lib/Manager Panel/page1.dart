import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Login Registeration/SignInOption/SignInOption.dart';
import '../utils/routes.dart';

class ManagerWebViewPage1 extends StatelessWidget {
  const ManagerWebViewPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyWebView(url: "http://${MyRoutes.ip}/Capstone/manager_panel_2/"),
      home: MyWebView(url: "http://${MyRoutes.ip}/Capstone/manager_panel_3/"),
      // home: MyWebView(url: 'http://192.168.1.44/dashboard/'),
      // home: const MyWebView(url: 'https://vwdsd.in'),
    );
  }
}

class MyWebView extends StatefulWidget {
  final String url;

  const MyWebView({super.key, required this.url});

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool isLoading = true;
  bool canGoBack = false;
  bool canGoForward = false;
  double progress = 0;
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  // late WebViewController _controller;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  // desktop site
  // bool _desktopModeEnabled = false;

  // ---------------------------
  int _backButtonCounter = 0;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  // --------------------------------
  // ignore: no_leading_underscores_for_local_identifiers
  Future<bool> _onWillPop() async {
    if (_backButtonCounter == 1) {
      // await _controller.clearCache();
      // await _controller.clearCookies();
      // Exit the app
      return true;
    } else {
      // Show a toast message
      // Fluttertoast.showToast(
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      //   msg: 'Press again to exit.',
      //   toastLength: Toast.LENGTH_SHORT,
      // );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Press again to exit'),
              // InkWell(
              //   onTap: () {},
              //   child: const Text("Close"),
              // ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // Increase the counter
      _backButtonCounter++;
      // Wait for 2 seconds
      await Future.delayed(const Duration(seconds: 2));
      // Reset the counter
      _backButtonCounter = 0;
      // Do not exit the app
      return false;
    }
  }

  // ----------------------
  final _key = UniqueKey();
  final Set<String> allowedUrls = {
    'https://www.google.com',
    'http://${MyRoutes.ip}/Capstone/',
    // 'http://${MyRoutes.ip}/Capstone/manager_panel_2/',
  };
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                otherAccountsPictures: const [
                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   child: Text(
                  //     'JD',
                  //     style: TextStyle(fontSize: 20.0),
                  //   ),
                  // ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   child: Text(
                  //     'JD',
                  //     style: TextStyle(fontSize: 20.0),
                  //   ),
                  // ),
                ],
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: NetworkImage(
                      // 'https://picsum.photos/800/300',
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSygbMutmF2nQBafMu0SRK5xQVs_knmCNH5xQ&usqp=CAU',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(20), child: const Image(image: AssetImage("assets/images/sign_In_Images/managerIcon.jpg"))),
                accountName: const Text("Ground Manager Name"),
                accountEmail: const Text("Ground Manager Email"),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChooseSignInOptionPage(),
                                  ));
                              Fluttertoast.showToast(
                                  backgroundColor: Colors.grey[600],
                                  textColor: Colors.white,
                                  msg: "Logged Out Succesfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  fontSize: 16.0);
                            },
                            child: const Text('Logout'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Dismiss dialog and do not logout
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
                title: const Text("Logout"),
              )
            ],
          ),
        ),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          elevation: 20,
          backgroundColor: Colors.grey,
          bottomOpacity: 20,
          title: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // child: Text(widget.url),
            child: const Text("Manager Panel"),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                final controller = await _controller.future;
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No back history item"),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () async {
                final controller = await _controller.future;
                if (await controller.canGoForward()) {
                  controller.goForward();
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No forward history item"),
                    ),
                  );
                }
              },
            ),

            // IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () async {
            //     if (canGoBack) {
            //       final controller = await _controller.future;
            //       controller.goBack();
            //     }
            //   },
            // ),
            // IconButton(
            //   icon: Icon(Icons.arrow_forward),
            //   onPressed: () async {
            //     if (canGoForward) {
            //       final controller = await _controller.future;
            //       controller.goForward();
            //     }
            //   },
            // ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                  progress = 1;
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              navigationDelegate: (NavigationRequest request) async {
                // if (request.url.startsWith('http://${MyRoutes.ip}/Capstone/manager_panel_2/')) {
                //   return NavigationDecision.navigate;
                // }
                // =========
                if (await canNavigate(request.url)) {
                  return NavigationDecision.navigate;
                }
                setState(() {
                  isLoading = true;
                });
                return NavigationDecision.prevent;
                // return NavigationDecision.navigate;

                // =================
                // Restrict With Functions
                //      if (await canNavigate(request.url)) {
                //   return NavigationDecision.navigate;
                // }
                // return NavigationDecision.prevent;
              },
              onProgress: (progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
              onPageStarted: (String url) {
                setState(() {
                  isLoading = true;
                  progress = 0;
                });
              },
            ),
            isLoading
                ? Center(
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 70,
                          width: 70,
                          color: Colors.black.withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/fife/APg5EOYsvtPPgIwOGGXatJGPtj5Eq-ED3v0CZ0AjqpXvuXaUZiE30SCjTSJbs-_5MlYjQQXXeid1qETxNvhDuNX4HMXhyOfLttAYCnhfnR73p0EsgeUd-Y5a7FwnulZ3DZosfzAbeePaz8mB6tVEj1XO500PH596lPV4HkQy9llcqmej0y6yD69Xxe6wTNqFDj2wTB8UcWEsnTsV9ipTpMhk5zhLPUnc5Wfp33TCB9igL7RKHAgBbSD-ynu92dHwZ0pnw0c1Gh6HwhEaWZvTm8bNgX_rQmhpTZ4V3831MUTV1lrvYW7o1FxG6Pt9GkCi2R0sT4Av73vFp1ucSxEzZHleAIzgCzZoyWCNcm1ViJPCuMbx4z02Ptpnk4auiuJNZgP2m3YoKm67IdGpIh6DcVSVcyQ3g3Nw6MG4SuqVEPP6Qlt4sGjWUBKx9YStdc0gUtYcO0XdBUeNPWswXsGxh4oE8OvOt7hC8ZkgHCQfx4_8LXCEO9Ctr5qaYIGAVhhGmZle9X_A5mgPhjVudCUs7Q2XhR8kyzNyZlxxoh3mPxo6cgD8c_GtLZU21OhDcgHCMCVKMaHCNoZ0CBk6OjPzGcsahUV9eFGIv4RlAEao1WxzFfBw8tI5zTanbFBy27opFJqYN666eFZWtKTKSyolNiFrvkMggvXZyB-_QcB0SFacAyrpRJWOvWlpuXvVW2MSDy1hIjPcTUiqRRhdtmHmQpHupZBkQOQo6xpuemoaqNFO4JvWn6iOzCzUgj4KQuczOApLtXfwvI1SCqmhcZwg3wERVzXj_niaqNdCvyeAhlonR8KR2yjGVBDXW5MXz3Ifl5KuKoJEkYayJMeneZ43evRNdnLpeUldcXAG1ZRw5tZnJaQ0pp3TBV5t1naZepZ2EAF0MTkSBRyyy-iORjKc1qBejHCQolMd4P_nZPFKcj34LUdJsGg9zfuPNQrgBribS3dbC9QfPrcZ9D_8CXD8DZaiziyoFDF1aPCqtK9jMOql-HO35qJmfVWE7jtxx0K8Wh4d3AeYyGor-dd257yL50ocrQfl2IAUqbNYd1IWDogeftD7yeGvu4qeoqssiYR_dNBYcNF9xr6l6mHy8S0W-PuxLtV1vJVQauPJFFMSL6z-1hE9XWL8_LwXiSLVRKjXu2qeiPTDJzhYoyPGGrU9g2VRIaLrALQKBrgCrdFh9H83K_cocMj5XOALSCtfSOG-IXK-lD34owjkBPZZ6zzOKgawuOtaSJ2PRXmxvohMYl-7JF4kB4lK_-CQo6k1Ww2m59FfC1aeT0k26FSUrAuWXnPP6R1SLqXYpaHhrr9ttGYEBx1iLXgDEucNuZaOvanhwOBjxAO93D_7u4JODXRO3WirYQAoaBhDE5Hbum3U7Sh2gAd0XAkXxndd7GuIirY87Nnj-uwxXLjNYj6lx08pOQ_l7hrEU-y1BHkSfNOuTsndbyDX2iBepFv4rm0KuKeXwveZqU85zaIaatcGcWVeG1d7ZIrOHEP6=w1920-h941',
                              fit: BoxFit.cover,
                              // width: double.infinity,
                              // height: double.infinity,
                              placeholder: (context, url) => Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            isLoading
                ? LinearPercentIndicator(
                    backgroundColor: Colors.black,
                    // backgroundColor: Colors.grey[300],
                    // progressColor: Colors.black,
                    lineHeight: 8.0,
                    // width: double.infinity,
                    percent: progress,
                    alignment: MainAxisAlignment.center,
                    // ignore: deprecated_member_use
                    linearGradient: LinearGradient(
                      colors: [
                        // Colors.white,
                        // Colors.black,
                        Colors.grey,
                        Colors.grey.shade700,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    width: MediaQuery.of(context).size.width,
                    center: Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  )
                // ==============================
                //  LinearPercentIndicator(
                //   backgroundColor: Colors.grey[300],
                //   // progressColor: Colors.blue,
                //   lineHeight: 8.0,
                //   // width: double.infinity,
                //   percent: progress,
                //   alignment: MainAxisAlignment.center,
                //   linearGradient: const LinearGradient(
                //     colors: [
                //       // Colors.white,
                //       // Colors.black,
                //       Colors.blueAccent, Colors.blue,
                //     ],
                //     begin: Alignment.centerLeft,
                //     end: Alignment.centerRight,
                //   ),
                //   width: MediaQuery.of(context).size.width,
                //   leading: CircleAvatar(
                //     radius: 20,
                //     child: Text(
                //       '${(progress * 100).toInt()}%',
                //       style: const TextStyle(fontSize: 14),
                //     ),
                //   ),
                // )

                // ==============================
                // progress < 1.0
                //     ? LinearProgressIndicator(
                //         value: progress,
                //         backgroundColor: Colors.white,
                //         valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                //       )
                // =========
                // ? LinearPercentIndicator(
                //     width: 200.0,
                //     lineHeight: 14.0,
                //     // percent: progress,
                //     percent: _progress,
                //     backgroundColor: Colors.grey,
                //     progressColor: Colors.blue,
                //     center: Text('${(_progress * 100).toStringAsFixed(0)}%'),
                //   )
                : Container(
                    // color: Colors.black.withOpacity(0.9),
                    ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
              progress = 0;
              // ==========

              // For LinearPercentIndicator
              // _progress += 0.1;
              // if (_progress > 1.0) {
              //   _progress = 0.0;
              // }
            });
            final controller = await _controller.future;
            controller.reload();
          },
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : const Icon(Icons.refresh),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkWebViewNavigation();
    _refreshWebView();
  }

  Future<void> _checkWebViewNavigation() async {
    final controller = await _controller.future;
    controller.canGoBack().then((value) {
      setState(() {
        canGoBack = value;
      });
    });

    controller.canGoForward().then((value) {
      setState(() {
        canGoForward = value;
      });
    });
  }

  Future<void> _refreshWebView() async {
    setState(() {
      isLoading = true;
      progress = 0;
    });
    final controller = await _controller.future;
    controller.reload();
  }

  Future<bool> canNavigate(String url) async {
    final Uri uri = Uri.parse(url);
    final String host = uri.host.toLowerCase();
    return allowedUrls.any((allowedUrl) => host.contains(Uri.parse(allowedUrl).host.toLowerCase()));
  }
}

// class _MyWebViewState extends State<MyWebView> {
//   final Completer<WebViewController> _controller = Completer<WebViewController>();

//   bool isLoading = true;
//   bool canGoBack = false;
//   bool canGoForward = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.url),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () async {
//               if (canGoBack) {
//                 final controller = await _controller.future;
//                 controller.goBack();
//               }
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward),
//             onPressed: () async {
//               if (canGoForward) {
//                 final controller = await _controller.future;
//                 controller.goForward();
//               }
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           WebView(
//             initialUrl: widget.url,
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               _controller.complete(webViewController);
//             },
//             onPageFinished: (String url) {
//               setState(() {
//                 isLoading = false;
//               });
//             },
//             navigationDelegate: (NavigationRequest request) {
//               setState(() {
//                 isLoading = true;
//               });
//               return NavigationDecision.navigate;
//             },
//           ),
//           isLoading
// ? Center(
//     child: SizedBox(
//       height: 80,
//       width: 80,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           height: 70,
//           width: 70,
//           color: Colors.black.withOpacity(0.8),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CachedNetworkImage(
//               imageUrl:
//                   'https://lh3.googleusercontent.com/fife/AMPSemf1rCKSkZkcbYy-Vrkx9B-U0Fvf5D1ASx2rUQjqX31x6ZvO916RbrT9iC68GKGn_6R0qX5gbz00cMpjKr6KH9Ii99_l301KOFhtAGHR91kuCBBGmLcN_PLnK9O8WI47_PXHYslWj939yBgxUpzs3fA0q8fe3NYaGNKGBfcnygIRuWLZf0WeP-bn8dGtpNFPbxeJcT_aczh5s_3PyR-J4Cu2XY7WCnvQq-IJbcr27elBVnOpwNUT1DwUfTBLg6p6KOXsqBuSTKa6iFAQ6FJ3w621BnrtLyMHk_2XCBknDIH-fG4n_RF1Dr2nciPTGJAthIkX96AUcSWswd_nIPgN0R9cPB6fYcdrc6HRBWbJQJo6LjPRs8aRWccK7-eI8tBL8GSdHoniyP8FvMByKW2hb72Ru_7asxt48suEND4DdRuA986m0Fn5yBXAzhM32Q78fe-uXiw8p_Rm-pKCvshi2I-1-f4-dfSzxzeOQTWe-s4hWh1-AqTKqc1KwOGFVcd2H4iyLWTiXtW1KoSqN8VyEPK4Ir5N3-IyWk88XeQxzT740rCTVwRYjXkIGYATVMVWRy8REftIRA3oZCNhYU92ipyoccVUMmvlv4sQTPk03Ij2XxdfDDF4bqg5Hr5lTazGw8HrOBSPFxaVXwwpGj7Co_IXpHtActj2_W-hyKPI0-q4k5bQaF2cmsNQf1kdtYq4hHz_Wrq-YfkXSz9q6vQYuL1IJF8JmElpnxNfPd2x8Di4iN2atZCdfMsz25DAXnLkNSSjqvQsjkHTlWAkGk08jV_fAvrGBdm5wleSTU_j1iHTue8PKToV3-4Qf5sRoskFQRWbhasSpQyxiTQDRfibr0eh-25PgWG_aoaq-C0Q0iO2-UP_qFG2y44mQwvWVKOqHZHF2OkpE7RaaDzm5IucvrNp3TFOhOwQw9V5sjytX5yoME7PJHcsWJmqT_3ieVyEY6il3zeyd8hNeXpCRHF976ekhl68_HXJq8jpvxUPN9tPjDQmR2mLMjP3u55dcrlJ5ZqxAFVwkRlOy219J8xR-VSDVhufeNcsujmjzPOaMFCfXtmivunklJ0GFTHhqUTOPd8Pi3QGEBwdYR8RDpLmiYr7tjPFDGsgOK4NDZulcpJU4xj9O9numu1zzo5xBQf1FNLFdM0450cvjhp5q2pKnykvAA9AF_9rwQIr3SEdbm8AX-VwxSsHoh-kRtAOvYGAhXLL0suOj-kVm1bqr-j8fOrZjkxJ1jlfWjSxypkMQYGyBNVjrH0JmRyB3fmlDkjYOJA3pJ6amREm7wZZRYIr5hp0ETqWqIWCCwgryg1hLNaj1U4_pSJj6X7w1_svJjrlellxPz14eDim7p1D0qbcYRa5ohWzk81sW6ClDdiw-tyrkn17x6L33ZVDH4DcCT8W80BQyxbxjdQx-aXk2t6lK0EfN-mF6TvsMWAs7i3tYjU4D6VATmaJru_RoGgN-v165fjEym6nJ_KWEvjDg88=w1920-h969',
//               fit: BoxFit.cover,
//               // width: double.infinity,
//               // height: double.infinity,
//               placeholder: (context, url) => Container(),
//             ),
//           ),
//         ),
//       ),
//     ),
//   )
//               : Container(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final controller = await _controller.future;
//           controller.reload();
//         },
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkWebViewNavigation();
//   }

//   Future<void> _checkWebViewNavigation() async {
//     final controller = await _controller.future;
//     controller.canGoBack().then((value) {
//       setState(() {
//         canGoBack = value;
//       });
//     });

//     controller.canGoForward().then((value) {
//       setState(() {
//         canGoForward = value;
//       });
//     });
//   }
// }
