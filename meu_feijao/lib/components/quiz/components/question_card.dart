import 'package:feijao_magico_uel/components/quiz/components/options.dart';
import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef MyPopUp = Widget;
_buildPopupDialog(BuildContext context, Questoes question, int index) {
  QuestionController _controller = Get.put(QuestionController());
  return AlertDialog(
    title: const Text('CORRIGIR QUESTÃO'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Text('TEM CERTEZA?'),
      ],
    ),
    actions: <Widget>[
      ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.exit_to_app),
        label: const Text('CANCELAR'),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[700],
          onPrimary: Colors.black,
        ),
      ),
      ElevatedButton.icon(
        onPressed: () {
        _controller.checkAns(question, index);
          Navigator.pop(context);
        }, // _controller.checkAns(question, index),
        icon: const Icon(Icons.check),
        label: const Text('CONFIRMAR?'),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[700],
          onPrimary: Colors.black,
        ),
      ),
    ],
  );
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final Questoes question;

  @override
  Widget build(BuildContext context) {
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
                question.question!,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 25),
            ...List.generate(
              question.options!.length,
              (index) => Option(
                index: index,
                text: question.options![index],
                press: () => showDialog(
                  barrierDismissible: false, //bloqueia toques fora do popup
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(
                    context,
                    question,
                    question.answerIndex!,
                  ),
                ),
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

