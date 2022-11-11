// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_first_app/utilities/CustomTextStyle.dart';
import 'package:news_first_app/utilities/HexColor.dart';

import '../AppColors.dart';

class Button extends StatelessWidget {
  final String name;
  VoidCallback? itemClick;
  final TextStyle? textStyle;

  Button(
      {Key? key, required this.name, required this.itemClick, required this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: itemClick,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                CustomTextStyle(context).btnBorderRadious()),
            side:
                BorderSide(color: HexColor(AppColors.primaryColor), width: 2)),
        color: HexColor(AppColors.mainColor),
        splashColor: HexColor(AppColors.bgGray),
        padding: EdgeInsets.fromLTRB(
            CustomTextStyle(context).btnHoriPadding(),
            CustomTextStyle(context).btnVertiPadding(),
            CustomTextStyle(context).btnHoriPadding(),
            CustomTextStyle(context).btnVertiPadding()),
        child: Text(name, textAlign: TextAlign.center, style: textStyle));
  }
}

class Button2 extends StatelessWidget {
  final String name;
  VoidCallback? itemClick;
  final TextStyle? textStyle;

  Button2(
      {Key? key, required this.name, required this.itemClick, required this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: itemClick,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                CustomTextStyle(context).btnBorderRadious()),
            side: const BorderSide(color: Colors.grey, width: 2)),
        color: Colors.white,
        splashColor: HexColor(AppColors.bgGray),
        padding: EdgeInsets.fromLTRB(
            CustomTextStyle(context).btnHoriPadding(),
            CustomTextStyle(context).btnVertiPadding(),
            CustomTextStyle(context).btnHoriPadding(),
            CustomTextStyle(context).btnVertiPadding()),
        child: Text(name, textAlign: TextAlign.center, style: textStyle));
  }
}
