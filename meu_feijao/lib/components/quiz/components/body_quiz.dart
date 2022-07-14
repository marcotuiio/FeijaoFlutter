// ignore_for_file: avoid_unnecessary_containers

import 'package:feijao_magico_uel/components/quiz/components/progress_bar.dart';
import 'package:feijao_magico_uel/components/quiz/components/question_card.dart';
import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:feijao_magico_uel/pages/responder_questoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyQuiz extends StatelessWidget {
  final String type;
  final int auxLen;
  const BodyQuiz({required this.type, required this.auxLen, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    // int len = 1;
    String tipo = '';
    if (type == 'R') {
      // len = auxLen; // 1
      tipo = 'Regar';
    } else if (type == 'E') {
      // len = auxLen; // max 9
      tipo = 'Estrelinhas';
    }
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ProgressBar(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text.rich(
                    TextSpan(
                      text: "Questão para $tipo",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.blue[900]),
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: finalLen, // questoes.length
                  itemBuilder: (context, finalLen) => QuestionCard(
                    question: sampledata[finalLen],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
