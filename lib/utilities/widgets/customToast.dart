import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_first_app/utilities/HexColor.dart';

import '../AppColors.dart';
import '../navigation_utils.dart';
// import 'package:toast/toast.dart';

class ErrorMsg {
  static void show(BuildContext context, String title, String msg,
      {GlobalKey<ScaffoldState>? key}) {
    if (key == null) {
      if (Platform.isAndroid) {
        Fluttertoast.showToast(
          msg: msg,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
        );
      } else if (Platform.isIOS) {
        showCupertinoDialog(
            context: context,
            builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0)), //this right here
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor(AppColors.primaryColor),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              height: 70,
                              child: Center(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              color: Colors.blue[50],
                              height: 150,
                              child: Center(
                                child: Text(
                                  msg,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              color: Colors.blue[50],
                              child: Center(
                                child: SizedBox(
                                  child: RaisedButton(
                                    onPressed: () {
                                      backButton(context);
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: HexColor(AppColors.primaryColor),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ));
      }
    } else {
      key.currentState!.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.error,
                  size: 40,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor(AppColors.highlightColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        msg,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor(AppColors.highlightColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
    }
  }
}
