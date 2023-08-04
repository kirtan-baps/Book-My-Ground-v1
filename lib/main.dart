import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp4/Home/Other%20Screens/historyOfBookedGround.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Home/HomePage.dart';
import 'Login Registeration/loginPage.dart';
import 'SplashScreens/SpashScreen_Custom.dart';
import 'SplashScreens/SpashScreen_Custom_Same.dart';
import 'ThemeData/theme.dart';
import 'utils/routes.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // ======
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   var username = preferences.getString('username');
//   // ======
//   // runApp(const MainPage());
//   runApp(
//     MaterialApp(
//       // theme: MyTheme.lighTheme(context),
//       // themeMode: ThemeMode.system,
//       // darkTheme: MyTheme.darkTheme(context),
//       debugShowCheckedModeBanner: false,
//       // home: username == null
//       //     ? AuthService().handleAuthState()
//       //     : MyRoutes.splashRouteToHome,

//       // initialRoute: username == null ? MyRoutes.splashRoute : MyRoutes.splashRouteToHome,
//       initialRoute: MyRoutes.splashRoute,

//       // initialRoute: MyRoutes.registerRoute,
//       routes: {
//         // '/': (context) => const HomePage(),
//         MyRoutes.splashRoute: (context) => const SplashScreen(),
//         MyRoutes.homeRoute: (context) => const HomePage(),
//         MyRoutes.splashRouteToHome: (context) => const SplashScreenForDirectLogin(),
//         // MyRoutes.loginRoute: (context) => const LoginPage(),
//         // MyRoutes.registerRoute: (context) => const RegisterPage(),
//         // MyRoutes.chooseSignInOption: (context) => const ChooseSignInOptionPage(),
//         // MyRoutes.stateRoute: (context) => StatePickerScreen(),
//         // MyRoutes.sliderTempRoute: (context) => const SliderTemp(),
//       },
//     ),
//   );
// }
Future<void> main() async {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    sharedPrefUsernameExistanceCheck();
  }

  String username = "";
  Future sharedPrefUsernameExistanceCheck() async {
    try {
      print("Working");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      username = preferences.getString('username')!;
      print(username);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lighTheme(),
      darkTheme: MyTheme.darkTheme(),
      // theme: MyTheme.lighTheme(context),
      // darkTheme: MyTheme.darkTheme(context),

      // initialRoute: MyRoutes.homeRoute,
      // initialRoute: MyRoutes.usernameSharedPref == null ? MyRoutes.splashRoute : MyRoutes.splashRouteToHome,

      // initialRoute: MyRoutes.splashRoute,
      // initialRoute: username == null ? MyRoutes.splashRoute : MyRoutes.splashRouteToHome,

      // ------------
      // Main
      // initialRoute: username != null ? MyRoutes.splashRouteToHome : MyRoutes.splashRoute,
      // ------------

      // initialRoute: username.isNotEmptyAndNotNull ? MyRoutes.splashRouteToHome : MyRoutes.splashRoute,

      // home: FutureBuilder(
      //   future: sharedPrefUsernameExistanceCheck(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.data != null) {
      //         // Navigate to the home page
      //         return const SplashScreenForDirectLogin();
      //       } else {
      //         // Navigate to the login page
      //         return const SplashScreen();
      //       }
      //     } else {
      //       // Show a loading indicator
      //       return CircularProgressIndicator();
      //     }
      //   },
      // ),
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!) {
              // Navigate to the home page
              return const SplashScreenForDirectLogin();
            } else {
              // Navigate to the login page
              return const SplashScreen();
            }
          } else {
            // Show a loading indicator
            return const CircularProgressIndicator();
          }
        },
      ),

      routes: {
        // '/': (context) => username.isEmpty ? const SplashScreen() : const SplashScreenForDirectLogin(),
        MyRoutes.splashRoute: (context) => const SplashScreen(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.splashRouteToHome: (context) => const SplashScreenForDirectLogin(),
        // MyRoutes.loginRoute: (context) => const LoginPage(),
        // MyRoutes.registerRoute: (context) => const RegisterPage(),
        // MyRoutes.chooseSignInOption: (context) => const ChooseSignInOptionPage(),
        // MyRoutes.stateRoute: (context) => StatePickerScreen(),
        // MyRoutes.sliderTempRoute: (context) => const SliderTemp(),
        MyRoutes.historyPageRoute: (context) => const HistoryOfBookedGround(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
