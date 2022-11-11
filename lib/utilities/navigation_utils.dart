import 'package:flutter/material.dart';
import 'package:news_first_app/views/dashboard/home.dart';

import '../views/dashboard/tabViews/detailView.dart';
import '../views/loginScreens/loginScreen.dart';
import '../views/loginScreens/userRegistraionScreen.dart';

void backButton(BuildContext context) {
  Navigator.pop(context);
}

void openLoginScren(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}

void openSignupScren(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Register()));
}

void openHomeScren(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const HomeView()));
}

void openDetailScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const DetailView()));
}
