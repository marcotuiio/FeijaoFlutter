import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);

  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (qnController) {
        // ignore: unused_element
        Future<dynamic> ?getRightPop() {
          if (qnController.isAnswered) {
            if (index == qnController.correctAns) {
              return showDialog( // adaptar para exibir certo ou errado
                context: context,
                builder: (BuildContext context) => _buildPopupDialogCerta(context),
              );
            } else if (index == qnController.selectedAns &&
                qnController.selectedAns != qnController.correctAns) {
                  return showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildPopupDialogErrada(context),
                  );
            }
          }
          return null;
        }

        return InkWell(
          onTap: press,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${index + 1}. $text",
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 16
                    ),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildPopupDialogCerta(BuildContext context) {
  return AlertDialog(
    title: const Text('RESPOSTA DA QUESTÃO:'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Text('CORRETA'),
      ],
    ),
    actions: <Widget>[
      ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.exit_to_app),
        label: const Text('OK'),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[700],
          onPrimary: Colors.black,
        ),
      ),
    ],
  );
}

Widget _buildPopupDialogErrada(BuildContext context) {
  return AlertDialog(
    title: const Text('RESPOSTA DA QUESTÃO:'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Text('INCORRETA'),
      ],
    ),
    actions: <Widget>[
      ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.exit_to_app),
        label: const Text('OK'),
        style: ElevatedButton.styleFrom(
          primary: Colors.red[700],
          onPrimary: Colors.black,
        ),
      ),
    ],
  );
}