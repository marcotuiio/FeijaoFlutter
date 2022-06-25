import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:flutter/material.dart';

class QuestController extends StatefulWidget {
  final List<Questoes> myQuest;
  // final int selIndex;
  // late String qTipo;
  const QuestController(
      {required this.myQuest, Key? key})
      : super(key: key);

  get pageController => null;

  @override
  State<QuestController> createState() => _QuestControllerState();
}

class _QuestControllerState extends State<QuestController> {
  late List<Questoes> questionList;
  late int selectedIndex;
  late int _correctIndex;
  late int _result;
  late String code;
  late PageController _pageController;
  PageController get pageController => _pageController;

  @override
  void initState() {
    super.initState();
    questionList = widget.myQuest;
    // selectedIndex = widget.selIndex;
    // _correctIndex = currentQuestion.answerIndex!;
    _pageController = PageController();
  }

  void checkAnswer(int index, QuestionModel question) {
    if (_correctIndex == selectedIndex) {
      setState(() {
        _result = 1;
      });
    } else {
      setState(() {
        _result = 0;
      });
    }
  }

  void nextQuestion() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return _buildPopupDialogResposta(context, _result);
  }

  Widget _buildPopupDialogResposta(BuildContext context, int result) {
    return AlertDialog(
      title: const Text('RESPOSTA DA QUESTÃO:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (result == 1) 
            const Text(
              'VOCÊ ACERTOU!',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          if (result == 0) 
            const Text(
              'VOCÊ ERROU!',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
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
}
