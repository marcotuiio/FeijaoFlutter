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
            return Colors.grey;
          }

        return InkWell(
          onTap: press,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: getTheRightColor(),
                width: 5,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${index + 1}. $text",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: getTheRightColor(),
                        width: 2,
                      ),
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

// Widget _buildPopupDialogCerta(BuildContext context) {
//   return AlertDialog(
//     title: const Text('RESPOSTA DA QUESTÃO:'),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const <Widget>[
//         Text('CORRETA'),
//       ],
//     ),
//     actions: <Widget>[
//       ElevatedButton.icon(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: const Icon(Icons.exit_to_app),
//         label: const Text('OK'),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.green[700],
//           onPrimary: Colors.black,
//         ),
//       ),
//     ],
//   );
// }

// Widget _buildPopupDialogErrada(BuildContext context) {
//   return AlertDialog(
//     title: const Text('RESPOSTA DA QUESTÃO:'),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const <Widget>[
//         Text('INCORRETA'),
//       ],
//     ),
//     actions: <Widget>[
//       ElevatedButton.icon(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: const Icon(Icons.exit_to_app),
//         label: const Text('OK'),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.red[700],
//           onPrimary: Colors.black,
//         ),
//       ),
//     ],
//   );
// }