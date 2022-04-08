// ignore_for_file: unrelated_type_equality_checks

import 'package:feijao_magico_uel/components/quiz/modelo/questions.dart';
import 'package:feijao_magico_uel/components/quiz/score_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
//import 'package:get/state_manager.dart';
// We use get package for our state management

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

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _recompensas = 0;
  int get recompensas => _recompensas;

  get tipo => 1; //1 rega, 0 estrelas

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
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    var tentativas = 0;
    var tipo = 1;
    //Regar = 1;
    //Estrelas = 0;

    if (_correctAns == _selectedAns && tentativas == 0) {
      //acertou na primeira
      if (tipo == 1) {
        _recompensas = _recompensas + 0; //não há penalidade de rega
      }
      if (tipo == 0) {
        _recompensas = _recompensas + 2; //recebe duas estrelinhas
      }
      tentativas = tentativas + 11;
      Future.delayed(const Duration(seconds: 0), () {
        nextQuestion();
      });

    } else if (_correctAns != _selectedAns && tentativas == 0) {
      //errou na primeira
      tentativas = tentativas + 10;
      if (tipo == 1) {
        _recompensas = _recompensas + 18; //9 de penalidade de rega
      }
      if (tipo == 0) {
        _recompensas = _recompensas + 0; //recebe uma estrelinhas
      }

      //repetir questão exibindo dica
      _animationController.reset();

    } else if (_correctAns == _selectedAns && tentativas == 10) {
      //acertou na segunda
      if (tipo == 1) {
        _recompensas = _recompensas - 9; //9 de penalidade de rega
      }
      if (tipo == 0) {
        _recompensas = _recompensas + 1; //recebe uma estrelinhas
      }
      tentativas = tentativas + 21;
      
      Future.delayed(const Duration(seconds: 0), () {
        nextQuestion();
      });

    } else if (_correctAns != _selectedAns && tentativas == 10) {
      //errou na segunda
      tentativas = tentativas + 20;
      Future.delayed(const Duration(seconds: 0), () {
        nextQuestion();
      });
    }

    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 2s it will go to the next qn
    // Future.delayed(const Duration(seconds: 2), () {
    //   nextQuestion();
    // });
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
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(const ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

}