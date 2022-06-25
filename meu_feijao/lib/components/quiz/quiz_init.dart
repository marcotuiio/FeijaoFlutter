import 'package:feijao_magico_uel/components/quiz/components/body_quiz.dart';
import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  final String code;
  const QuizScreen({required this.code, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          MaterialButton(
              onPressed: _controller.nextQuestion, child: const Text("Pular")),
        ],
      ),
      body: const Body(),
    );
  }
}
