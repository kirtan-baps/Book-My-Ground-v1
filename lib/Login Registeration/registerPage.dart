import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:velocity_x/velocity_x.dart';

import 'loginPage.dart';
import 'registerPage2.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _isVisible = false;
  late bool _isObsecure = true;
  TextEditingController usernameC = TextEditingController();
  TextEditingController lnameC = TextEditingController();
  TextEditingController fnameC = TextEditingController();
  // TextEditingController phoneC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  String numberC = "";
  // var phone = "";
  final formkey1 = GlobalKey<FormState>();
  final FocusNode usernameFocusNode = FocusNode();

  // @override
  // void initState() {
  //   countryC.text = "+91";
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
          child: Form(
            key: formkey1,
            child: Column(
              children: [
                // const Text(
                //   "Welcome",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 30.0,
                //   ),
                // ),
                "Welcome".text.xl5.color(context.theme.accentColor).make(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 80),
                    child: SizedBox(width: 100.0, height: 100.0, child: Image.asset("assets/images/sign_In_Images/login.png")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                  child: SizedBox(
                    width: 450.0,
                    child: TextFormField(
                      // focusNode: usernameFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Username";
                        }
                        // if (!RegExp(r'^[a-z_]+$').hasMatch(value)) {
                        if (!RegExp(r'^[a-z0-9_]*$').hasMatch(value)) {
                          // return 'Please enter only lowercase letters and underscores';
                          return 'Please enter only lowercase letters and underscores';
                        }
                        return null;
                      },
                      maxLength: 12,
                      // keyboardType: TextInputType.text,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                        // FilteringTextInputFormatter.allow(RegExp(r'^[a-z0-9_]*$')),
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]+')),
                        // FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9_]*$')),
                        // FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+[a-zA-Z0-9_]*[a-zA-Z0-9]+$')),
                      ],
                      controller: usernameC,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        // fillColor: Colors.grey.withOpacity(0.4),
                        // filled: true,
                        // border: const OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(15.0),
                        //   ),
                        // ),
                        labelText: "Username",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                  child: SizedBox(
                    width: 450.0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                            child: SizedBox(
                              width: 350.0,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter FirstName";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]+')),
                                ],
                                controller: fnameC,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  // fillColor: Colors.grey.withOpacity(0.4),
                                  // filled: true,
                                  // border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                  labelText: "First Name",
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                            child: SizedBox(
                              width: 450.0,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Lastname";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]+')),
                                ],
                                controller: lnameC,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  // fillColor: Colors.grey.withOpacity(0.4),
                                  // filled: true,
                                  // border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                  labelText: "Last Name",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                //   child: SizedBox(
                //     width: 450.0,
                //     child: TextFormField(
                //       keyboardType: TextInputType.number,
                //       controller: phoneC,
                //       decoration: InputDecoration(
                //         prefixIcon: const Icon(Icons.phone),
                //         fillColor: Colors.grey.withOpacity(0.4),
                //         filled: true,
                //         border: const OutlineInputBorder(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(15.0))),
                //         labelText: "Phone Number",
                //       ),
                //     ),
                //   ),
                // ),
                IntlPhoneField(
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+*/-]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    // border: OutlineInputBorder(
                    //     borderSide: BorderSide(),
                    //     ),
                  ),
                  onChanged: (phone) {
                    numberC = phone.completeNumber;
                    print(numberC);
                    print(numberC.runtimeType);
                    // print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                //   child: SizedBox(
                //     width: 450.0,
                //     child: Container(
                //       height: 62,
                //       decoration: BoxDecoration(
                //         color: Colors.grey.withOpacity(0.4),
                //         border: Border.all(width: 2, color: Colors.grey),
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           SizedBox(
                //             width: 40,
                //             child: TextFormField(
                //               validator: (value) {
                //                 if (value!.isEmpty) {
                //                   return "Please Enter Country Code";
                //                 }
                //                 return null;
                //               },
                //               controller: countryC,
                //               keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                //               inputFormatters: [
                //                 FilteringTextInputFormatter.allow(RegExp(r'[0-9+*/-]')),
                //               ],
                //               decoration: InputDecoration(
                //                 fillColor: Colors.grey.withOpacity(0.4),
                //                 border: InputBorder.none,
                //               ),
                //             ),
                //           ),
                //           const Text(
                //             "|",
                //             style: TextStyle(fontSize: 33, color: Colors.grey),
                //           ),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           Expanded(
                //             child: TextFormField(
                //               validator: (value) {
                //                 if (value!.isEmpty) {
                //                   return "Please Enter PhoneNumber";
                //                 }
                //                 return null;
                //               },
                //               controller: phoneC,
                //               // onChanged: (value) {
                //               //   phone = value;
                //               // },
                //               keyboardType: TextInputType.number,
                //               inputFormatters: [
                //                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                //               ],
                //               decoration: const InputDecoration(
                //                 border: InputBorder.none,
                //                 hintText: "Phone",
                //               ),
                //             ),
                //           ),
                //           // Expanded(
                //           //   child: TextField(
                //           //     onChanged: (value) {
                //           //       phone = value;
                //           //     },
                //           //     keyboardType: TextInputType.phone,
                //           //     decoration: const InputDecoration(
                //           //       border: InputBorder.none,
                //           //       hintText: "Phone",
                //           //     ),
                //           //   ),
                //           // ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 10.0),
                  child: SizedBox(
                    width: 450.0,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Password";
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*])[a-zA-Z\d!@#\$%\^&\*]{8,}$').hasMatch(value)) {
                          return 'Password must contain at least one uppercase letter,\none lowercase letter, one number, and one sign (!@#\$%\^&\*).';
                        }
                        return null;
                      },
                      controller: passwordC,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'''[a-zA-Z0-9!@#\$%\^&\*\(\)-_=\+\[\]\{\}\|;:\'",.<>/?\\`~]''')),
                      ],
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
                      obscureText: _isObsecure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObsecure = !_isObsecure;
                              });
                            },
                            icon: Icon(_isObsecure ? Icons.visibility_off : Icons.visibility)),
                        prefixIcon: const Icon(Icons.lock),
                        // fillColor: Colors.grey.withOpacity(0.4),
                        // filled: true,
                        // border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Password",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
                  child: SizedBox(
                    width: 100.0,
                    height: 55.0,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        if (formkey1.currentState!.validate()) {
                          // String num = countryC.text + phoneC.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterPage2(
                                  usernameC: usernameC.text.toString(),
                                  fnameC: fnameC.text.toString(),
                                  lnameC: lnameC.text.toString(),
                                  // phoneC: '${countryC.text  phone}',
                                  // phoneC: num,
                                  phoneC: numberC,
                                  passwordC: passwordC,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            // child: Text(
                            //   "Next",
                            //   style: TextStyle(color: Colors.white, fontSize: 17),
                            // ),
                            child: "Next".text.color(context.cardColor).bold.xl.make(),
                          ),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                //     child: TextButton(
                //       style: TextButton.styleFrom(
                //         // shadowColor: Colors.blue,
                //         // elevation: 20,
                //         backgroundColor: context.accentColor,
                //       ),
                //       onPressed: () {
                //         // Navigator.push(
                //         //   context,
                //         //   MaterialPageRoute(
                //         //     builder: (context) => const LoginPage(),
                //         //   ),
                //         // );
                //         Navigator.pop(context);
                //       },
                //       // child: const Text(
                //       //   "Already User.! Please Login",
                //       //   style: TextStyle(
                //       //     color: Colors.black,
                //       //     fontWeight: FontWeight.bold,
                //       //     fontSize: 13.0,
                //       //   ),
                //       // ),
                //       child: "Already User! Please Login".text.color(context.cardColor).bold.subtitle2(context).make(),
                //     ),
                //   ),
                // ),
              ],
            ),
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
            Navigator.pop(context);
          },
          // child: Text(
          //   "Don't have an account?",
          //   style: TextStyle(
          //     color: context.cardColor,
          //     fontSize: 13.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          child: "Already User! Please Login".text.color(context.accentColor).bold.subtitle2(context).make(),
        ),
      ),
    );
  }
}
