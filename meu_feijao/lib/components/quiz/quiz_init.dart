import 'package:feijao_magico_uel/components/quiz/components/body_quiz.dart';
import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  final String code;
  final int index;
  const QuizScreen({required this.code, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController(index: index, code: code));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          MaterialButton(
            onPressed: _controller.nextQuestion,
            child: const Text("Pular"),
          ),
        ],
      ),
      body: const BodyQuiz(),
    );
  }
}
