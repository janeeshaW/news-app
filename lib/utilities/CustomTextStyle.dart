import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'DeviceType.dart';



class CustomTextStyle {
  late BuildContext context;
  late Device _device;

  CustomTextStyle( this.context){
    _device = DeviceType(width: MediaQuery.of(context).size.width).getType();
  }

  TextStyle headline() {
    return Theme.of(context).textTheme.headline5!.copyWith(
      color: Colors.white,
      fontSize: _device  == Device.mobile ? 25 : 40,
      fontFamily: 'Nunito-Black',
    );
  }
   TextStyle headlineBlack() {
    return Theme.of(context).textTheme.headline5!.copyWith(
      color: Colors.black,
      fontSize: _device  == Device.mobile ? 25 : 40,
      fontFamily: 'Nunito-Black',
    );
  }

  TextStyle subhead() {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
        color: Colors.white,
        fontSize: _device  == Device.mobile ? 15 : 30,
        fontFamily: 'Nunito-Light'
    );
  }

  TextStyle body1() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: _device  == Device.mobile ? 20 : 30,
        fontFamily: 'Nunito-Black'
    );
  }
  TextStyle body4() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: _device  == Device.mobile ? 15 : 25,
        fontFamily: 'Nunito-Black'
    );
  }
  TextStyle body5() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: _device  == Device.mobile ? 12 : 25,
        fontFamily: 'Nunito-Black'
    );
  }
   TextStyle body6() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: _device  == Device.mobile ? 12 : 25,
        fontFamily: 'Nunito-Black'
    );
  }
   TextStyle body8() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: _device  == Device.mobile ? 12 : 25,
        fontFamily: 'Nunito-SemiBold'
    );
  }
  TextStyle body3() {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: _device  == Device.mobile ? 20 : 30,
        fontFamily: 'Nunito-Black'
    );
  }


  TextStyle body2() {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        color: Colors.black,
        fontSize: _device  == Device.mobile ? 15 : 25,
        fontFamily: 'Nunito-SemiBold'
    );
  }
  
  TextStyle body7() {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        color: Colors.black,
        fontSize: _device  == Device.mobile ? 12 : 25,
        fontFamily: 'Nunito-SemiBold'
    );
  }
  TextStyle body2Small() {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        color: Colors.white,
        fontSize: _device  == Device.mobile ? 12.5 : 17,
        fontFamily: 'Nunito-Light'
    );
  }

  TextStyle title() {
    return Theme.of(context).textTheme.headline6!.copyWith(
        color: Colors.white,
        fontSize: _device  == Device.mobile ? 12 : 25,
        fontFamily: 'Nunito-Black'
    );
  }

  TextStyle smallButton() {
    return Theme.of(context).textTheme.button!.copyWith(
      color: Colors.white,
      fontSize: _device  == Device.mobile ? 15 : 25,
      fontFamily: 'Nunito-Black',
    );
  }

  TextStyle blueText() {
    return Theme.of(context).textTheme.button!.copyWith(
      color: Colors.blue,
      fontSize: _device  == Device.mobile ? 15 : 25,
      fontFamily: 'Nunito-SemiBold',
    );
  }

  TextStyle button() {
    return Theme.of(context).textTheme.button!.copyWith(
        color: Colors.white,
        fontSize: _device  == Device.mobile ? 20 : 30,
        fontFamily: 'Nunito-Black',
    );
  }

  double btnHoriPadding(){
    return _device == Device.mobile ? 30 : 40;
  }

  double btnVertiPadding(){
    return _device == Device.mobile ? 5 : 10;
  }

  double btnBorderRadious(){
    return _device == Device.mobile ? 25 : 35;
  }

  

 

}