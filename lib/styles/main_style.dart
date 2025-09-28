import 'package:flutter/material.dart';

class AppStyles {
  static const title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white70,
  );

  static const card = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static const textProgress = TextStyle(
      color: Colors.greenAccent,
      fontSize: 15
  );
}