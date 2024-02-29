import 'dart:async';
import 'package:cad_for_thorax_diseases/Screens/main_screen.dart';
import 'package:cad_for_thorax_diseases/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isHome(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!=null){
      Timer(
          const Duration(seconds: 3),
              () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MainScreen())));
    }
    else{
      Timer(
          const Duration(seconds: 3),
              () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home())));
    }

  }
}
