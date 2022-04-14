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
        Color getTheRightColor() {
          if (qnController.isAnswered) {
            if (index == qnController.correctAns) {
              return Colors.green;
            } else if (index == qnController.selectedAns &&
                qnController.selectedAns != qnController.correctAns) {
              return Colors.red;
            }
          }
          return Colors.black38;
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
        }

        return InkWell(
          onTap:  press,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: getTheRightColor()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${index + 1}. $text",
                    style: TextStyle(color: getTheRightColor(), fontSize: 16),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: getTheRightColor() == Colors.green
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor()),
                    ),
                    child: getTheRightColor() == Colors.grey
                        ? null
                        : Icon(getTheRightIcon(), size: 16),
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
