import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp4/Widgets/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'BottomNavigationBarScreens/profilePage.dart';
import 'BottomNavigationBarScreens/groundpage_Screen.dart';
import 'BottomNavigationBarScreens/homepage_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    // const Text("LOL1"),
    const HomePageScreen(),
    const GroundPage(),
    const ProfilePage9(),
    // const HomePageScreen(),
    // const GroundPage(),
    // const Category_page(),
    // const Profile_Page(),
  ];
  @override
  Widget build(BuildContext context) {
    int _backButtonCounter = 0;

    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _onWillPop() async {
      if (_backButtonCounter == 1) {
        // Exit the app
        return true;
      } else {
        ToastsClass.regularToast('Press again to exit');
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

    // --------------------------------
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          body: screens[index],
          // drawerScrimColor: Colors.amber,
          // backgroundColor: const Color.fromRGBO(255, 255, 255, 1),

          bottomNavigationBar: FlashyTabBar(
            height: 55,
            backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
            // backgroundColor: context.theme.bottomNavigationBarTheme.backgroundColor,
            // animationCurve: Curves.linear,
            // animationCurve: Curves.easeInCirc,
            // animationCurve: Curves.easeInQuint,
            animationCurve: Curves.elasticOut,
            animationDuration: const Duration(milliseconds: 700),
            selectedIndex: index,
            iconSize: 30,
            showElevation: false, // use this to remove appBar's elevation
            onItemSelected: (indexx) => setState(() {
              index = indexx;
            }),
            items: [
              FlashyTabBarItem(
                activeColor: Colors.white,
                // inactiveColor: Colors.white,
                // icon: const Icon(Icons.home_rounded),
                icon: Image.asset(
                  "assets/images/bottomNavIcons/home.png",
                  // color: const Color(0xff9496c1),
                  color: Colors.blue,
                  width: 35,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Color(0xfff5f5f5)),
                ),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,

                // icon: const Icon(Icons.sports_cricket_rounded),
                icon: Image.asset(
                  "assets/images/bottomNavIcons/ground.png",

                  // color: const Color(0xff9496c1),
                  width: 35,
                ),
                title: const Text(
                  'Grounds',
                  style: TextStyle(color: Color(0xfff5f5f5)),
                ),
              ),
              FlashyTabBarItem(
                activeColor: Colors.white,

                // icon: const Icon(Icons.account_circle_rounded),
                icon: Image.asset(
                  "assets/images/bottomNavIcons/profile.png",
                  // color: Color.fromRGBO(20, 135, 211, 1),
                  width: 35,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Color(0xfff5f5f5)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
