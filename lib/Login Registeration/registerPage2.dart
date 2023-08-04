// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp4/Widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/routes.dart';
import 'verifyOTP.dart';

// ignore: must_be_immutable
class RegisterPage2 extends StatefulWidget {
  RegisterPage2({super.key, required this.usernameC, required this.fnameC, required this.lnameC, required this.phoneC, required this.passwordC});
  static String verify = "";

  String usernameC = "";
  String lnameC = "";
  String fnameC = "";
  String phoneC = "";
  TextEditingController passwordC = TextEditingController();

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  @override
  void initState() {
    super.initState();
    print(widget.usernameC);
    print(widget.fnameC);
    print(widget.lnameC);
    print(widget.phoneC);
  }

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

  Future<void> insertDetailFuncWithSharedPref() async {
    try {
      // String uri ="https://cricketground.000webhostapp.com/Capstone/project_1/register_main.php";
      // String uri = "http://10.0.2.2/Capstone/project_1/register_main.php";
      String uri = "http://${MyRoutes.ip}/Capstone/project_2/register.php";
      // String uri = "https://${MyRoutes.ipweb}/Capstone/project_2/register.php";
      print(Uri.parse(uri));
      // ignore: unused_local_variable
      var res = await http.post(
        Uri.parse(uri),
        body: {
          "username": widget.usernameC,
          "fname": widget.fnameC,
          "lname": widget.lnameC,
          "phone": widget.phoneC,
          "country": countryValue,
          "state": stateValue,
          "city": cityValue,
          "password": widget.passwordC.text,
        },
      );

      var data = json.decode(res.body);
      if (data.toString() == "Error") {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        ToastsClass.regularToast('User already exist!');
      } else {
        debugPrint("Record Inserted");
        print(data.toString());
        print(data['firstname']);
        print(data['id']);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('id', data['id']);
        preferences.setString('username', data['username']);
        preferences.setString('fname', data['firstname']);
        preferences.setString('lname', data['lastname']);
        preferences.setString('phone', data['phone']);
        preferences.setString('email', data['email']);
        preferences.setString('country', data['country']);
        preferences.setString('state', data['state']);
        preferences.setString('city', data['city']);
        setState(() {});
        await FirebaseAuth.instance.verifyPhoneNumber(
          // phoneNumber: widget.phoneC,
          phoneNumber: widget.phoneC,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            RegisterPage2.verify = verificationId;
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const MyVerify();
              },
            ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

        ToastsClass.regularToast('Please Wait...!');
      }
    } catch (e) {
      debugPrint("Error is ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(width: 300.0, height: 300.0, child: Image.asset("assets/images/state_page.png")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: CSCPicker(
                    selectedItemStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    layout: Layout.vertical,
                    // flagState: CountryFlag.ENABLE,

                    // defaultCountry: CscCountry.India,
                    onCountryChanged: (country) {
                      try {
                        setState(() {
                          countryValue = country;
                          print(countryValue);
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    onStateChanged: (state) {
                      try {
                        setState(() {
                          stateValue = state!;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    onCityChanged: (city) {
                      try {
                        setState(() {
                          cityValue = city!;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    // countryDropdownLabel: "*Country",
                    // stateDropdownLabel: "*State",
                    // cityDropdownLabel: "*City",
                    dropdownDialogRadius: 30,
                    searchBarRadius: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 46.0, 0.0, 20.0),
                  child: SizedBox(
                    width: 100.0,
                    height: 55.0,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        // insertDetailFunc();
                        insertDetailFuncWithSharedPref();
                      },
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Next",
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
