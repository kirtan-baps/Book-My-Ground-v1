import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:myapp4/Widgets/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/routes.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  bool _isObscure = true;
  bool _isVisible = false;
  final formkey1 = GlobalKey<FormState>();
  bool loginCheckBool = false;

  Future<void> loginFuncWithSharedPref() async {
    if (formkey1.currentState!.validate()) {
      try {
        // NotWorking
        // var uri = Uri.http(
        //   "cricketground.000webhostapp.com",
        //   '/Capstone/main/login.php',
        //   {'q': '{http}'},
        // );

        // Working
        // var uri = Uri.http(
        //     // "10.0.2.2",
        //     MyRoutes.ip,
        //     '/Capstone/project_1/login.php',
        //     {'q': '{http}'});

        // Working
        print(uname);
        String uri = "http://${MyRoutes.ip}/Capstone/project_2/login.php";

        // String uri = "https://${MyRoutes.ipweb}/Capstone/project_2/login.php";
        print(uri);
        var res = await http.post(
          Uri.parse(uri),
          // uri,
          body: {
            // "username": usernameC.text,
            "username": uname,
            "password": passwordC.text,
          },
        );
        var data = json.decode(res.body);
        if (data.toString() == "Error") {
          ToastsClass.regularToast('Username or Password is Invalid.');
          debugPrint("Registeration Not Done");
        } else {
          debugPrint("Record Found1");
          // setState(() {});

          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(content: Text("Welcome..!")));

          setState(() {
            loginCheckBool = true;
            // loginCheckBool = !loginCheckBool;
          });
          ToastsClass.regularToast('Welcome..!');

          // -------------------------
          print(data);
          print(data['firstname']);

          print(data['email']);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('id', data['id']);
          preferences.setString('username', data['username']);
          preferences.setString('fname', data['firstname']);
          preferences.setString('lname', data['lastname']);
          preferences.setString('email', data['email']);
          preferences.setString('phone', data['phone']);
          preferences.setString('country', data['country']);
          preferences.setString('state', data['state']);
          preferences.setString('city', data['city']);

          print("This is Username ${preferences.getString('username')}");
          await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
          // Navigator.pushNamed(context, MyRoutes.homeRoute);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  String welcome_Str = "Welcome, ";
  String usernameC_Str = "Back!";
  bool username_Str_bool = false;
  String uname = "";
  bool changeButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SingleChildScrollView(
        child: Form(
          key: formkey1,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
              //   // child: Text(
              //   //   "Welcome Back,",
              //   //   style: TextStyle(
              //   //     color: Theme.of(context).accentColor,
              //   //     fontSize: 30.0,
              //   //   ),
              //   // ),
              //   // ignore: deprecated_member_use
              //   child: welcome_Str.text.xl4.color(context.theme.accentColor).make(),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    height: 70,
                    width: 330,
                    duration: const Duration(seconds: 2),
                    color: context.accentColor,
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                        text: "Welcome, ",
                        style: TextStyle(
                          color: context.canvasColor,
                          fontSize: 25.0,
                        ), // Default text style for the entire text
                        children: <TextSpan>[
                          TextSpan(
                            text: usernameC_Str,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ), // Default text style for the entire text

                            // style: const TextStyle(
                            //   fontWeight: FontWeight.bold,
                            //   color: Colors.blue,
                            // ), // Custom style for the "world!" text
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(width: 100.0, height: 100.0, child: Image.asset("assets/images/sign_In_Images/login.png")),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                  child: SizedBox(
                    width: 350.0,
                    child: TextFormField(
                      // controller: usernameC,
                      onChanged: (value) {
                        uname = value;
                        setState(() {
                          username_Str_bool = true;
                          welcome_Str = "";
                          usernameC_Str = "$value!";
                          if (value.isEmpty) {
                            usernameC_Str = "Back!";
                          }
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Username";
                        }
                        return null;
                      },
                      // keyboardType: TextInputType.text,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(8),
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]+')),
                      ],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        // fillColor: Colors.grey.withOpacity(0.4),
                        // filled: true,
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(15.0),
                        //   ),
                        // ),
                        labelText: "Username",
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 350.0,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'''[a-zA-Z0-9!@#\$%\^&\*\(\)-_=\+\[\]\{\}\|;:\'",.<>/?\\`~]'''),
                      ),
                    ],
                    controller: passwordC,
                    // obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      // fillColor: Colors.grey.withOpacity(0.4),
                      // filled: true,
                      // border: const OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(15.0),
                      //   ),
                      // ),
                      labelText: "Password",
                    ),
                    obscureText: _isObscure,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    //
                    loginFuncWithSharedPref();
                    // setState(() {
                    //   loginCheckBool = false;
                    // });
                  },
                  child: AnimatedContainer(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                      borderRadius: loginCheckBool
                          ? BorderRadius.circular(18)
                          : const BorderRadius.only(topLeft: Radius.elliptical(20, 20), bottomRight: Radius.elliptical(20, 20)),
                      color: loginCheckBool ? Colors.green : context.accentColor,
                    ),
                    width: loginCheckBool ? 50 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    duration: const Duration(seconds: 1),
                    child: loginCheckBool
                        ? Icon(
                            Icons.done,
                            color: context.cardColor,
                          )
                        : "Login".text.xl2.semiBold.color(context.cardColor).make(),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       elevation: 20,
              //       // shadowColor: Colors.white,
              //       // ignore: deprecated_member_use
              //       backgroundColor: context.theme.accentColor,
              //     ),
              //     onPressed: () {
              //       // loginFunc();
              //       loginFuncWithSharedPref();
              //     },
              //     child: "Login".text.color(context.cardColor).bold.subtitle2(context).make(),
              //   ),
              // ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextButton(
              //       style: TextButton.styleFrom(
              //         elevation: 20,
              //         backgroundColor: context.accentColor,
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const RegisterPage(),
              //           ),
              //         );
              //       },
              //       // child: Text(
              //       //   "Don't have an account?",
              //       //   style: TextStyle(
              //       //     color: context.cardColor,
              //       //     fontSize: 13.0,
              //       //     fontWeight: FontWeight.bold,
              //       //   ),
              //       // ),
              //       child: "Don't have an account?".text.color(context.cardColor).bold.subtitle2(context).make(),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: TextButton.styleFrom(
              // elevation: 20,
              // backgroundColor: context.accentColor,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
          // child: Text(
          //   "Don't have an account?",
          //   style: TextStyle(
          //     color: context.cardColor,
          //     fontSize: 13.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          child: "Don't have an account? Sign Up".text.color(context.accentColor).bold.subtitle2(context).make(),
        ),
      ),
    );
  }
}
