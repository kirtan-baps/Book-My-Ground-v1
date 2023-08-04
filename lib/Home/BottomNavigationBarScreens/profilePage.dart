import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp4/Widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Login Registeration/SignInOption/SignInOption.dart';
import '../../OtherScreens/editProfile.dart';
import '../../ThemeData/theme.dart';
import '../Other Screens/historyOfBookedGround.dart';
import 'HomeScreenInterals/HomeScreenHeader.dart';

class ProfilePage9 extends StatefulWidget {
  const ProfilePage9({Key? key}) : super(key: key);

  @override
  State<ProfilePage9> createState() => _ProfilePage9State();
}

class _ProfilePage9State extends State<ProfilePage9> {
  String? id = "";
  String? username = "";
  String? fname = "";
  String? lname = "";
  String? email = "";
  String? phone = "";
  String? country = "";
  String? state = "";
  String? city = "";

  Future getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      id = preferences.getString('id');
      username = preferences.getString('username');
      fname = preferences.getString('fname');
      lname = preferences.getString('lname');
      email = preferences.getString('email');
      phone = preferences.getString('phone');
      country = preferences.getString('country');
      state = preferences.getString('state');
      city = preferences.getString('city');
    });
  }

  Future logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideAction(
                innerColor: context.accentColor,
                outerColor: context.cardColor,
                // submittedIcon: Icon(Icons.bakery_dining),
                submittedIcon: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/images/byeLogout.png'),
                ),
                // height: 50,
                // sliderButtonIconSize: 20,
                borderRadius: 12,
                sliderRotate: false,
                text: "Slide to Logout",
                textStyle: TextStyle(
                  fontSize: 15,
                  color: context.accentColor,
                ),

                onSubmit: () async {
                  // debugPrint("Done");
                  Navigator.pop(context);
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.setString('email', "Email is not added yet.");
                  preferences.remove('username');
                  ToastsClass.regularToast('Logged Out Succesfully');
                  // ignore: use_build_context_synchronously
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const LoginPage();
                  //   },
                  // ), (route) => false);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChooseSignInOptionPage(),
                    ),
                  );
                },
              ),
            ),
            // TextButton(
            //   onPressed: () async {
            //     // Dismiss dialog and perform logout
            //     Navigator.pop(context);
            //     SharedPreferences preferences = await SharedPreferences.getInstance();
            //     preferences.setString('email', "Email is not added yet.");
            //     preferences.remove('username');
            //     ToastsClass.regularToast('Logged Out Succesfully');
            //     // ignore: use_build_context_synchronously
            //     // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            //     //   builder: (context) {
            //     //     return const LoginPage();
            //     //   },
            //     // ), (route) => false);
            //     // ignore: use_build_context_synchronously
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const ChooseSignInOptionPage(),
            //       ),
            //     );
            //     // Perform logout action here
            //   },
            //   child: const Text('Logout'),
            // ),
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
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  bool isOpened = false;

  // ===================Theme====Changer Code------------==========

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      closeIcon: Icon(
        Icons.close_outlined,
        color: context.cardColor,
      ),
      key: _endSideMenuKey,
      inverse: true, // end side menu
      background: context.backgroundColor,
      // type: SideMenuType.shrinkNSlide,
      type: SideMenuType.slideNRotate,
      // maxMenuWidth: 350,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: buildMenu(),
      ),
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: SideMenu(
        background: context.backgroundColor,
        key: _sideMenuKey,
        menu: buildMenu(),
        type: SideMenuType.slideNRotate,
        onChange: (_isOpened) {
          setState(() => isOpened = _isOpened);
        },
        child: IgnorePointer(
          ignoring: isOpened,
          child: Scaffold(
            // appBar: AppBar(
            //   // backgroundColor: context.theme.appBarTheme.backgroundColor,
            //   backgroundColor: Vx.gray900,

            //   actions: [
            //     IconButton(
            //       icon: const Icon(Icons.menu),
            //       onPressed: () => toggleMenu(true),
            //     )
            //   ],
            // ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  // HomeScreenHeader(nameText: 'Hello, ${}',),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeScreenHeader(
                        nameText: username == '' ? 'Hello, User' : 'Hello, ${username!.replaceRange(0, 1, username![0].toUpperCase())}',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 40,
                            onPressed: () => toggleMenu(true),
                            icon: Image.asset(
                              'assets/images/drawer.png',
                              // height: 200,
                              // width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   height: 280,
                  //   width: double.infinity,
                  //   child: Image.asset(
                  //     'assets/images/profile_temp.jpg',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                color: context.primaryColor,
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(left: 110.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "$fname $lname",
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                              ),
                                              const Text(
                                                "All Rounder",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          CircleAvatar(
                                            backgroundColor: Colors.green,
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const EditProfile(),
                                                    ),
                                                  );
                                                },
                                                // onPressed: () => toggleMenu(true),
                                                icon: Icon(
                                                  Icons.edit_outlined,
                                                  color: context.accentColor,
                                                  size: 18,
                                                )),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onHover: (value) {},
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.grey[400],
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/sign_In_Images/profileedit.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                margin: const EdgeInsets.only(left: 20.0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text("Profile Information"),
                              ),
                              const Divider(),
                              ListTile(
                                title: const Text("Phone"),
                                subtitle: Text(phone == '' ? '+??????????' : phone!),
                                leading: const Icon(Icons.phone),
                              ),
                              ListTile(
                                title: const Text("Email"),
                                subtitle: Text(email == '' ? 'Not Added' : email!),
                                leading: const Icon(Icons.mail_outline),
                              ),
                              ListTile(
                                title: const Text("Address"),
                                subtitle: Text(
                                    // country == '' && state == null && city == null ? '+??????????' : "$city, $state, ${country!.substring(8)}",
                                    // ),
                                    // : "$city, $state, ${country!}"),
                                    country == '' && state == null && city == null ? '+??????????' : "$city, $state."),
                                leading: const Icon(Icons.map),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: const [
          //       CircleAvatar(
          //         backgroundColor: Colors.white,
          //         radius: 22.0,
          //       ),
          //       SizedBox(height: 16.0),
          //       Text(
          //         "Hello, John Doe",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       SizedBox(height: 20.0),
          //     ],
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ),
              );
            },
            leading: const Icon(Icons.account_circle_outlined, size: 20.0, color: Colors.white),
            title: const Text("Edit Profile"),
            textColor: Colors.white,
            // dense: true,
          ),
          ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryOfBookedGround(),
              ),
            ),
            leading: const Icon(Icons.history_outlined, size: 20.0, color: Colors.white),
            title: const Text("History"),
            textColor: Colors.white,
            // dense: true,
          ),
          ListTile(
            onTap: () => ToastsClass.regularToast('Available in Beta'),
            leading: const Icon(Icons.contact_support_outlined, size: 20.0, color: Colors.white),
            title: const Text("Neep Support"),
            textColor: Colors.white,
            // dense: true,
          ),
          ListTile(
            onTap: () => logout(context),
            leading: const Icon(Icons.login_outlined, size: 20.0, color: Colors.white),
            title: const Text("Logout"),
            textColor: Colors.white,
            // dense: true,
          ),
        ],
      ),
    );
  }
}
