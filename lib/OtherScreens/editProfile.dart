import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp4/Home/BottomNavigationBarScreens/HomeScreenInterals/HomeScreenHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import 'package:characters/characters.dart';

import '../utils/routes.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController eusername = TextEditingController();
  TextEditingController efname = TextEditingController();
  TextEditingController elname = TextEditingController();
  TextEditingController eemail = TextEditingController();
  TextEditingController ephone = TextEditingController();
  TextEditingController ecountry = TextEditingController();
  TextEditingController estate = TextEditingController();
  TextEditingController ecity = TextEditingController();

  Future edit() async {
    var url = Uri.http(
      MyRoutes.ip,
      '/Capstone/project_2/ProfileData/editprofile.php',
    );

    // ignore: avoid_print
    print(url);

    var response = await http.post(url, body: {
      "id": id,
      // "username": eusername.text,
      "firstname": efname.text,
      "lastname": elname.text,
      "email": eemail.text,
      "phone": ephone.text,
      "country": ecountry.text,
      "state": estate.text,
      "city": ecity.text,
    });
    // ignore: non_constant_identifier_names
    var data = json.decode(response.body);
    if (data.toString() == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'cancel',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('fname', data['firstname']);
      await preferences.setString('lname', data['lastname']);
      await preferences.setString('email', data['email']);
      await preferences.setString('phone', data['phone']);
      await preferences.setString('country', data['country']);
      await preferences.setString('state', data['state']);
      await preferences.setString('city', data['city']);
      setState(() {});
      //
      Fluttertoast.showToast(
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        msg: 'Your Profile is Edited Succesfully',
        toastLength: Toast.LENGTH_SHORT,
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  String id = '';
  String username = "";
  String fname = "";
  String lname = "";
  String email = "";
  String phone = "";
  String country = "";
  String state = "";
  String city = "";

  Future getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('id')!;
      username = preferences.getString('username')!;
      fname = preferences.getString('fname')!;
      lname = preferences.getString('lname')!;
      email = preferences.getString('email')!;
      phone = preferences.getString('phone')!;
      country = preferences.getString('country')!;
      state = preferences.getString('state')!;
      city = preferences.getString('city')!;
      // ============== Set it in Controller
      eusername.text = username;
      efname.text = fname;
      elname.text = lname;

      eemail.text = email;
      ephone.text = phone;

      String processText(String text) {
        final emojiRegex = RegExp(
            r'[\u{1F600}-\u{1F64F}]|[\u{1F300}-\u{1F5FF}]|[\u{1F680}-\u{1F6FF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}]|[\u{1F900}-\u{1F9FF}]|[\u{1F1E6}-\u{1F1FF}]',
            unicode: true);
        if (text.characters.any((char) => emojiRegex.hasMatch(char))) {
          return text.substring(8);
        } else {
          return text;
        }
      }

      // ecountry.text = country;
      ecountry.text = processText(country);
      estate.text = state;
      ecity.text = city;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
                  ),
                ],
              ),
              HomeScreenHeader(nameText: 'Edit Profile'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).clearSnackBars();

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Username connot be changed.")));
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: eusername,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          // prefixIcon: Icon(Icons.account_circle),
                          labelText: "Username",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Firstname",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: efname,
                      decoration: InputDecoration(
                        hintText: fname,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Lastname",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: elname,
                      decoration: InputDecoration(
                        hintText: lname,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Email",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: eemail,
                      decoration: InputDecoration(
                        hintText: eemail.text.isEmpty ? "Email not Registed" : "",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: ephone,
                      decoration: InputDecoration(
                        hintText: phone,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Country",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: ecountry,
                      decoration: InputDecoration(
                        hintText: country,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "State",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: estate,
                      decoration: InputDecoration(
                        hintText: state,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "City",
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: ecity,
                      decoration: InputDecoration(
                        hintText: city,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 60,
                        width: 300,
                        child: ListView(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600]),
                              onPressed: () => edit(),
                              child: const Text("Save"),
                            ),
                          ],
                        ),
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
