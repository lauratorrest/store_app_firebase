// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  final Widget child;

  CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _createCardShape(), 
        child: child,     
      ),
    );
  }

  BoxDecoration _createCardShape() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset:  Offset(0,5)
        )
      ]
    );
  }
}