import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lighTheme() => ThemeData(
        // fontFamily: GoogleFonts.lato().fontFamily,
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness: Brightness.light,
        canvasColor: creamColor,
        cardColor: Colors.white,
        buttonColor: darkbluishColor,
        primarySwatch: createMaterialColor(Colors.black45), // Using custom MaterialColor,
        shadowColor: darkbluishColor,
        backgroundColor: darkCreamColor,
        accentColor: darkbluishColor,
        scaffoldBackgroundColor: creamColor,
        // primaryColor: darkbluishColor,

        //
        // appBarTheme: AppBarTheme(
        //   color: Colors.black,
        //   elevation: 0.0,
        //   iconTheme: const IconThemeData(
        //     color: Colors.black,
        //   ),
        //   titleTextStyle: Theme.of(context).textTheme.titleLarge,
        // ),

        //
        inputDecorationTheme: const InputDecorationTheme(
          // Update the background color for different states (enabled, focused, disabled)
          // You can use any color you prefer as the background color
          // For this example, we're using Colors.yellow for enabled state, Colors.red for focused state, and Colors.grey for disabled state
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            // borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            // borderRadius: BorderRadius.circular(8.0),
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey),
          //   // borderRadius: BorderRadius.circular(8.0),
          // ),
          errorBorder: InputBorder.none,
          errorStyle: TextStyle(
            color: Colors.redAccent,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkColorForBottomNavBar,
          // selectedItemColor: lightColorForBottomNavBar,
          // unselectedItemColor: Colors.white,
          // selectedLabelStyle: TextStyle(color: Colors.green),
          // unselectedLabelStyle: TextStyle(color: Colors.white),
        ),
      );
  static ThemeData darkTheme() => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        accentColor: creamColor,
        brightness: Brightness.dark,
        canvasColor: darkCreamColor,
        cardColor: Colors.black,
        buttonColor: Colors.black, // Using custom MaterialColor,
        shadowColor: darkCreamColor,
        backgroundColor: darkbluishColor,
        scaffoldBackgroundColor: darkCreamColor,
        // primaryColor: creamColor,

        //

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkColorForBottomNavBar,
          // selectedItemColor: lightColorForBottomNavBar,
          // unselectedItemColor: Colors.white,
          // selectedLabelStyle: TextStyle(color: Colors.green),
          // unselectedLabelStyle: TextStyle(color: Colors.white),
        ),

        //
        // appBarTheme: AppBarTheme(
        //   color: Colors.white,
        //   elevation: 0.0,
        //   iconTheme: const IconThemeData(
        //     color: Colors.white,
        //   ),
        //   titleTextStyle: Theme.of(context)
        //       .textTheme
        //       .copyWith(
        //         titleLarge: context.textTheme.titleLarge!.copyWith(color: Colors.white),
        //       )
        //       .titleLarge,
        // ),

        //
        inputDecorationTheme: const InputDecorationTheme(
          // Update the background color for different states (enabled, focused, disabled)
          // You can use any color you prefer as the background color
          // For this example, we're using Colors.yellow for enabled state, Colors.red for focused state, and Colors.grey for disabled state
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            // borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            // borderRadius: BorderRadius.circular(8.0),
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.yellow),
          //   // borderRadius: BorderRadius.circular(8.0),
          // ),
          errorBorder: InputBorder.none,
          // errorBorder: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          // ),
          errorStyle: TextStyle(
            color: Colors.redAccent,
          ),
        ),
      );

  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkbluishColor = const Color(0xff403b58);
  // ignore: constant_identifier_names
  //
  static Color darkCreamColor = Vx.gray900;
  static Color lightBluishColor = Vx.indigo500;
  //
  // static Color lightColorForBottomNavBar = Color.fromRGBO(116, 117, 119, 1);
  static Color darkColorForBottomNavBar = const Color.fromRGBO(36, 36, 36, 1);
}

MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int strength in strengths) {
    swatch[strength] = Color.fromRGBO(r, g, b, strength / 1000.0);
  }

  return MaterialColor(color.value, swatch);
}
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:velocity_x/velocity_x.dart';

// class MyTheme {
//   static ThemeData lighTheme(BuildContext context) => ThemeData(
//         // fontFamily: GoogleFonts.lato().fontFamily,
//         fontFamily: GoogleFonts.poppins().fontFamily,
//         brightness: Brightness.light,
//         canvasColor: creamColor,
//         cardColor: Colors.white,
//         buttonColor: darkbluishColor,
//         accentColor: darkbluishColor,
//         primarySwatch: createMaterialColor(Colors.black45), // Using custom MaterialColor,
//         shadowColor: darkbluishColor,

//         //
//         appBarTheme: AppBarTheme(
//           color: Colors.black,
//           elevation: 0.0,
//           iconTheme: const IconThemeData(
//             color: Colors.black,
//           ),
//           titleTextStyle: Theme.of(context).textTheme.titleLarge,
//         ),

//         //
//         inputDecorationTheme: const InputDecorationTheme(
//           // Update the background color for different states (enabled, focused, disabled)
//           // You can use any color you prefer as the background color
//           // For this example, we're using Colors.yellow for enabled state, Colors.red for focused state, and Colors.grey for disabled state
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             // borderRadius: BorderRadius.circular(8.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//             // borderRadius: BorderRadius.circular(8.0),
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             // borderRadius: BorderRadius.circular(8.0),
//           ),
//           errorBorder: InputBorder.none,
//           errorStyle: TextStyle(
//             color: Colors.redAccent,
//           ),
//         ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: darkColorForBottomNavBar,
//           // selectedItemColor: lightColorForBottomNavBar,
//           // unselectedItemColor: Colors.white,
//           // selectedLabelStyle: TextStyle(color: Colors.green),
//           // unselectedLabelStyle: TextStyle(color: Colors.white),
//         ),
//       );
//   static ThemeData darkTheme(BuildContext context) => ThemeData(
//         fontFamily: GoogleFonts.poppins().fontFamily,
//         accentColor: creamColor,
//         brightness: Brightness.dark,
//         canvasColor: darkCreamColor,
//         cardColor: Colors.black,
//         buttonColor: Colors.black, // Using custom MaterialColor,
//         shadowColor: darkCreamColor,
//         //

//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: darkColorForBottomNavBar,
//           // selectedItemColor: lightColorForBottomNavBar,
//           // unselectedItemColor: Colors.white,
//           // selectedLabelStyle: TextStyle(color: Colors.green),
//           // unselectedLabelStyle: TextStyle(color: Colors.white),
//         ),

//         //
//         appBarTheme: AppBarTheme(
//           color: Colors.black,
//           elevation: 0.0,
//           iconTheme: const IconThemeData(
//             color: Colors.white,
//           ),
//           titleTextStyle: Theme.of(context)
//               .textTheme
//               .copyWith(
//                 titleLarge: context.textTheme.titleLarge!.copyWith(color: Colors.white),
//               )
//               .titleLarge,
//         ),

//         //
//         inputDecorationTheme: const InputDecorationTheme(
//           // Update the background color for different states (enabled, focused, disabled)
//           // You can use any color you prefer as the background color
//           // For this example, we're using Colors.yellow for enabled state, Colors.red for focused state, and Colors.grey for disabled state
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             // borderRadius: BorderRadius.circular(8.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//             // borderRadius: BorderRadius.circular(8.0),
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.red),
//             // borderRadius: BorderRadius.circular(8.0),
//           ),
//           errorBorder: InputBorder.none,
//           // errorBorder: OutlineInputBorder(
//           //   borderSide: BorderSide.none,
//           // ),
//           errorStyle: TextStyle(
//             color: Colors.redAccent,
//           ),
//         ),
//       );

//   static Color creamColor = const Color(0xfff5f5f5);
//   static Color darkbluishColor = const Color(0xff403b58);
//   // ignore: constant_identifier_names
//   //
//   static Color darkCreamColor = Vx.gray900;
//   static Color lightBluishColor = Vx.indigo500;
//   //
//   // static Color lightColorForBottomNavBar = Color.fromRGBO(116, 117, 119, 1);
//   static Color darkColorForBottomNavBar = Color.fromRGBO(32, 32, 32, 1);
// }

// MaterialColor createMaterialColor(Color color) {
//   List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
//   Map<int, Color> swatch = <int, Color>{};
//   final int r = color.red, g = color.green, b = color.blue;

//   for (int strength in strengths) {
//     swatch[strength] = Color.fromRGBO(r, g, b, strength / 1000.0);
//   }

//   return MaterialColor(color.value, swatch);
// }
