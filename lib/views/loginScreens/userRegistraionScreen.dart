import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_first_app/views/dashboard/home.dart';
import 'package:news_first_app/views/loginScreens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/AppColors.dart';
import '../../utilities/CustomTextStyle.dart';
import '../../utilities/DeviceType.dart';
import '../../utilities/HexColor.dart';
import '../../utilities/SessionManager.dart';
import '../../utilities/navigation_utils.dart';
import '../../utilities/widgets/Button.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loaderVisible = false;
  bool validName = false, validPass = false, validConfirmPass = false;
  String name = "", password = "", confirmPassword = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var textViewHeight = DeviceType(width: width).getType() == Device.mobile
        ? width * 0.16
        : width * 0.1;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(height * .05),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.fitHeight,
                          height: height * 0.15,
                          width: double.infinity,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: textViewHeight,
                            margin: EdgeInsets.only(
                              left: width * 0.07,
                              right: width * 0.07,
                              top: width * 0.05,
                            ),
                            child: TextField(
                              onChanged: (value) {
                                name = value.trim();

                                if (validateName(name) == '') {
                                  setState(() {
                                    validName = true;
                                  });
                                } else {
                                  setState(() {
                                    validName = false;
                                  });
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: CustomTextStyle(context)
                                  .body2Small()
                                  .copyWith(
                                    color: HexColor(AppColors.primaryColor),
                                  ),
                              decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  hintText: "Enter User Name..",
                                  errorText: validateName(name),
                                  errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            height: textViewHeight,
                            margin: EdgeInsets.only(
                                left: width * 0.07,
                                right: width * 0.07,
                                top: width * 0.01,
                                bottom: width * 0.0),
                            child: TextField(
                              onChanged: (value) {
                                password = value.trim();
                                if (validatePassword(value) == '') {
                                  setState(() {
                                    validPass = true;
                                  });
                                } else {
                                  setState(() {
                                    validPass = false;
                                  });
                                }
                              },
                              style: CustomTextStyle(context)
                                  .body2Small()
                                  .copyWith(
                                    color: HexColor(AppColors.primaryColor),
                                  ),
                              obscureText: true,
                              decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  hintText: "Enter Password",
                                  errorText: validatePassword(password),
                                  errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            height: textViewHeight,
                            margin: EdgeInsets.only(
                                left: width * 0.07,
                                right: width * 0.07,
                                top: width * 0.01,
                                bottom: width * 0.04),
                            child: TextField(
                              obscureText: true,
                              onChanged: (value) {
                                confirmPassword = value.trim();

                                if (validateConfirmPassword(
                                        password, confirmPassword) ==
                                    '') {
                                  setState(() {
                                    validConfirmPass = true;
                                  });
                                } else {
                                  setState(() {
                                    validConfirmPass = false;
                                  });
                                }

                                confirmPassword = value.trim();
                              },
                              style: CustomTextStyle(context)
                                  .body2Small()
                                  .copyWith(
                                    color: HexColor(AppColors.primaryColor),
                                  ),
                              decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  hintText: "Confirm Password",
                                  errorText: validateConfirmPassword(password, confirmPassword),
                                  errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Button(
                            name: '  Sign Up  ',
                            itemClick: validateFields() == true
                                ? () {
                                    registerUser();
                                  }
                                : null,
                            textStyle: null,
                          ),
                          SizedBox(
                            height: width * 0.14,
                          ),
                          Container(
                            height: 2,
                            width: double.maxFinite,
                            color: Colors.grey[300],
                            margin: const EdgeInsets.only(top: 40, bottom: 40),
                          ),
                          InkWell(
                            onTap: () {
                              openLoginScren(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Already Have an Account?',
                                  style: CustomTextStyle(context)
                                      .title()
                                      .copyWith(
                                          color:
                                              HexColor(AppColors.primaryColor)),
                                ),
                                Text(
                                  '  Sign In',
                                  style: CustomTextStyle(context)
                                      .title()
                                      .copyWith(
                                          color: HexColor(AppColors.mainColor)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width * 0.09,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String validatePassword(String text) {
    if (text.isEmpty) {
      return 'Provide a password';
    } else if (text.length < 7) {
      return 'Invalid Password';
    } else {
      return '';
    }
  }

  String validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Confirm Password';
    } else if (password != confirmPassword) {
      return 'Password Mismatched';
    } else {
      return '';
    }
  }

  String validateName(String email) {
    if (email.isEmpty) {
      return 'Provide a User Name';
    } else {
      return '';
    }
  }

  bool validateFields() {
    return (validPass == true && validName == true && validConfirmPass == true);
  }

  void _showLoader(bool visible) {
    setState(() {
      loaderVisible = visible;
    });
  }

  registerUser() async {
    FocusScope.of(context).requestFocus(FocusNode());
    _showLoader(true);
    SessionManager().setUser(true);
    SessionManager().setUsers(name, password);
    openHomeScren(context);
  }

  Widget progressView(bool show) {
    if (loaderVisible) {
      return const CircularProgressIndicator();
    } else {
      return Container();
    }
  }
}
