import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Manager Panel/page1.dart';
import '../loginPage.dart';

class ChooseSignInOptionPage extends StatefulWidget {
  const ChooseSignInOptionPage({super.key});

  @override
  State<ChooseSignInOptionPage> createState() => _ChooseSignInOptionPageState();
}

class _ChooseSignInOptionPageState extends State<ChooseSignInOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(),

      backgroundColor: Colors.grey,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: InkWell(
                    highlightColor: Colors.grey,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // title: Text('Are you a manager?'),
                            title: const Text('Do you have Ground manager Credentials?'),
                            actions: [
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ManagerWebViewPage1(),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset("assets/images/sign_In_Images/managerIcon.jpg"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/images/sign_In_Images/Lock.jpg"),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 130, 0, 15),
                child: Text(
                  "Hey There,\nWelcome",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                // width: screenSize.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 70, 20, 10),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shadowColor: Colors.black,
                            elevation: 20,
                            backgroundColor: Colors.black,
                          ),
                          label: const Text(
                            'Login with Google',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          // icon: const CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //       "https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1=s94-rw"),
                          //   radius: 20,
                          // ),
                          onPressed: () {
                            // AuthService().signInWithGoogle();
                            Fluttertoast.showToast(
                              // fontSize: 10,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white,
                              backgroundColor: Colors.grey[600],
                              msg: 'Counstruction On Process..!',
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shadowColor: Colors.black,
                          elevation: 20,
                          backgroundColor: Colors.black,
                        ),
                        label: const Text(
                          'Login with Facebook',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        icon: const FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        // icon: const CircleAvatar(
                        //   backgroundImage: NetworkImage(
                        //       "https://1000logos.net/wp-content/uploads/2021/04/Facebook-logo.png"),
                        //   radius: 20,
                        // ),
                        onPressed: () {
                          Fluttertoast.showToast(
                            // fontSize: 10,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            backgroundColor: Colors.grey[600],
                            msg: 'Counstruction On Process..!',
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: const Text(
                        "Already have an account? Log in",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
