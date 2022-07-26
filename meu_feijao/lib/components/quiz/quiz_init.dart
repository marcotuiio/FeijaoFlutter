// ignore_for_file: unused_local_variable

import 'package:feijao_magico_uel/components/quiz/components/body_quiz.dart';
import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String code;
  final int index;
  final String type;
  final int len;
  const QuizScreen(
      {required this.code,
      required this.index,
      required this.type,
      required this.len,
      Key? key})
      : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController(
        index: widget.index, code: widget.code));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SelecionarJogo(),
              //   ),
              // );
            },
          ),
        ],
      ),
      body: BodyQuiz(type: widget.type, leng: widget.len),
    );
  }
}
