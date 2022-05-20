// import 'dart:io';
import 'package:feijao_magico_uel/components/quiz/modelo/questions.dart';
import 'package:feijao_magico_uel/pages/body.dart';
// import 'package:feijao_magico_uel/components/quiz/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
//import 'package:get/state_manager.dart';

class QuestionController extends GetxController
    // ignore: deprecated_member_use
    with
        // ignore: deprecated_member_use
        SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = sampledata
      .map(
        (question) => Question(
          id: question['id'],
          question: question['question'],
          options: question['options'],
          answer: question['answer_index'],
          //comentario: question['comentario'],
        ),
      )
      .toList();
  List<Question> get questions => _questions;

  // int forcaAux = snapshot.forca;
  // int stars = snapshot.estrelinhas;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  late String _tipo; //P rega, E estrelas
  String get tipo => _tipo;

  // ignore: prefer_final_fields
  int _tentativas = 0;
  int get tentativas => _tentativas; 

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;


  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController = AnimationController(
        duration: const Duration(seconds: 600), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }
    // It will stop the counter
    _animationController.stop();
    update();

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });

    //Regar = 'P';
    //Estrelas = 'E';

    // TO DO: gravar no arquivo questoes_respondidas_[codigo do game].json no registro

    // if (_correctAns == _selectedAns && _tentativas == 0) {
    //   //acertou na primeira
    //   if (tipo == 'P') {
    //     forcaAux = forcaAux + 0; //não há penalidade de rega
    //   }
    //   if (tipo == 'E') {
    //     stars = stars + 2; //recebe duas estrelinhas
    //   }
    //   marcar no json dessa questao que tentativa = 11;
    //   Future.delayed(const Duration(seconds: 3), () {
    //     nextQuestion();
    //   });

    // } else if (_correctAns != _selectedAns && _tentativas == 0) {
    //   //errou na primeira
    //   _tentativas = 10;
    //   if (tipo == 'P') {
    //     forcaAux = forcaAux - 9; //9 de penalidade de rega
    //   }
    //   if (tipo == 'E') {
    //     stars = stars + 0; //recebe uma estrelinhas
    //   }

    //   //repetir questão exibindo dica
    //   marcar no json dessa questao que tentativa = 10;

    //   _animationController.reset();

    // } else if (_correctAns == _selectedAns && _tentativas == 10) {
    //   //acertou na segunda
    //   if (tipo == 'P') {
    //     forcaAux = forcaAux - 0; //9 de penalidade de rega ja aplicada
    //   }
    //   if (tipo == 'E') {
    //     stars = stars + 1; //recebe uma estrelinhas
    //   }
  
    //   marcar no json dessa questao que tentativa = 21;
      
    //   Future.delayed(const Duration(seconds: 3), () {
    //     nextQuestion();
    //   });

    // } else if (_correctAns != _selectedAns && _tentativas == 10) {
    //   //errou na segunda
    //   if (tipo == 'P') {
    //     forcaAux = forcaAux - 9; //total 18 de penalidade de rega 
    //   }
    //   if (tipo == 'E') {
    //     stars = stars + 0; //total 0 estrelinhas
    //   }

    //   marcar no json dessa questao que tentativa = 20;
    //                              !!!!!!!!!!!!!!!!!!
    //   !!!!!!!!!!!!!!!!!! marcar no json do game forca = forcaAux e estrelinhas = stars; !!!!!!!!!!!!!!!!!!
    //                              !!!!!!!!!!!!!!!!!!
    
    //   Future.delayed(const Duration(seconds: 3), () {
    //     nextQuestion();
    //   });
    // }

  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
      _tentativas = 0;
    } else {
      Get.to(() => const HomeScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

}

// _write(String text) async {
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final File file = File('${directory.path}/my_file.txt');
//   await file.writeAsString(text);
// }


