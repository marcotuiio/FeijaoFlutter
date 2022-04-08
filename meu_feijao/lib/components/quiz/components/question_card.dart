import 'package:feijao_magico_uel/components/quiz/components/options.dart';
import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feijao_magico_uel/components/quiz/modelo/questions.dart';


class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                question.question,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    !.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 25),
            ...List.generate(
              question.options.length,
              (index) => Option(
                index: index,
                text: question.options[index],
                press: () => _controller.checkAns(question, index),
              ),
            ),
            // Text(
            //   question.comentary,
            //   style: Theme.of(context)
            //       .textTheme
            //       .headline6
            //       !.copyWith(color: Colors.black),
            // ),
          ],
        ),
      ),
    );
  }
}