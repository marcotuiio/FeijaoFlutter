import 'package:feijao_magico_uel/components/quiz/controler/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String type;
    QuestionController _qnController = Get.put(QuestionController());
    if (_qnController.tipo == 'P') {
      type = '- PENALIDADE DE REGA';
    } else {
      type = ' + ESTRELINHAS';
    }
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Spacer(flex: 3),
              Text(
                "RESULTADO",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    !.copyWith(color: Colors.yellow),
              ),
              const Spacer(),
              Text(
                "${_qnController.correctAns} $type",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.yellow),
              ),
              const Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
