// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [

          _PurpleBox(),

          _HeaderIcon(),

          child

        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Icon(Icons.person_pin, color: Colors.white, size: 100)
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(top: 130, left: 30, child: _Bubble()),
          Positioned(top: -40, left: -30, child: _Bubble()),
          Positioned(top: 70, right: -40, child: _Bubble()),
          Positioned(top: -50, left: 200, child: _Bubble()),
          Positioned(top: 200, left: 250, child: _Bubble()),
        ],
      )
    );
  }

  BoxDecoration _purpleBackground() => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]
    )
  );
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}