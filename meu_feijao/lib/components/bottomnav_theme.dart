// ignore: file_names
import 'package:flutter/material.dart';

final bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.green[800],
    selectedIconTheme: IconThemeData(
      color: Colors.grey[800],
      //size: 24,
    ),
    selectedLabelStyle: TextStyle(
      color: Colors.grey[800],
      fontSize: 12,
    ),
    unselectedIconTheme: const IconThemeData(
      color: Colors.black,
      //size: 24,
    ),
    unselectedLabelStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
);
