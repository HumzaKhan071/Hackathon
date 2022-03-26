import 'dart:async';

import 'package:e_cars_ui/authentication/login_screen.dart';
import 'package:e_cars_ui/const.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class spscreen extends StatefulWidget {
  const spscreen({Key? key}) : super(key: key);

  @override
  State<spscreen> createState() => _spscreenState();
}

class _spscreenState extends State<spscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueGrey2,
        body: Center(
          child: Container(
            child:Lottie.asset('assets/93527-moving-car.json'),
          ),
        ));
  }
}
