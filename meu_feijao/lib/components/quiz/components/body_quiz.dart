import 'package:feijao_magico_uel/components/quiz/components/progress_bar.dart';
import 'package:feijao_magico_uel/components/quiz/components/question_card.dart';
import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyQuiz extends StatelessWidget {
  final String type;
  const BodyQuiz({required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    int len = 1;
    if (type == 'P') {
      len = 1;
    } else if (type == 'E') {
      len = _questionController.questions.length;
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
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${_questionController.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.blue[900]),
                      // children: <Widget>[
                      //   TextSpan(
                      //     text: "/${_questionController.questions.length}",
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline5
                      //         !.copyWith(color: Colors.blue[900]),
                      //   ),
                      // ],
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: len,
                  itemBuilder: (context, index) => QuestionCard(
                    question: _questionController.questions[index],
                  ),
                ),
              ),
              //getText()
            ],
          ),
        )
      ],
    );
  }
}
