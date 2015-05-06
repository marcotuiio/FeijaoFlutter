import 'package:feijao_magico_uel/components/bottomNav_theme.dart';
import 'package:feijao_magico_uel/pages/body.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PeDeFeijaoAPP());
}

class PeDeFeijaoAPP extends StatelessWidget {
  const PeDeFeijaoAPP({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        bottomNavigationBarTheme: bottomNavigationBarTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
