import 'package:feijao_magico_uel/components/bottomnav_theme.dart';
import 'package:feijao_magico_uel/pages/config_inicio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const PeDeFeijaoAPP());
}

class PeDeFeijaoAPP extends StatelessWidget {
  const PeDeFeijaoAPP({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.dark();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        textTheme: _appTextTheme(base.textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: const CadastroInicial(),
      navigatorKey: Get.key,
    );
  }
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith(
    headline1: base.headline1?.copyWith(
      fontWeight: FontWeight.w500,
    ),
    subtitle1: base.subtitle1?.copyWith(
      fontSize: 18,
      color: Colors.black45,
    ),
    caption: base.caption?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodyText1: base.bodyText1?.copyWith(
      fontSize: 17,
      color: Colors.grey,
    ),
    button: base.button?.copyWith(
      letterSpacing: 3,
      fontSize: 16,
    ),
  );
}
