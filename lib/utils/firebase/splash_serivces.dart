import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';



import 'package:flutter/material.dart';

import '../../view/home_screen.dart';
import '../../view/view.dart';

class SplashServices {
  isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 4),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomeScreen())));
    } else {
      Timer(
          const Duration(seconds: 4),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const LogInScreen())));
    }
  }
}
