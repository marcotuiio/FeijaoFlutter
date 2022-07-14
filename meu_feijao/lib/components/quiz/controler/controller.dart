// ignore_for_file: deprecated_member_use,

// import 'dart:convert';
import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:feijao_magico_uel/network/update_quest.dart';
import 'package:feijao_magico_uel/network/update_relatorio.dart';
import 'package:feijao_magico_uel/network/updates_on_file.dart';
import 'package:feijao_magico_uel/pages/responder_questoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late int index;
  late String code;
  late String type;

  QuestionController(
      {this.index = 0, this.code = '', this.type = '', Key? key});

  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  late int _currentIndex;
  late String _currentCode;
  late String _currentType;
  final UpdateOnFile _updatesGame = UpdateOnFile();
  final UpdateQuestions _updateQuestions = UpdateQuestions();
  final UpdateRelatorio _updateRelatorio = UpdateRelatorio();

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    super.onInit();
    _currentIndex = index;
    _currentCode = code;
    _currentType = type;
    _animationController = AnimationController(
        duration: const Duration(seconds: 600), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Questoes question, int selectedIndex) async {
    _isAnswered = true;
    _correctAns = question.answerIndex!;
    _selectedAns = selectedIndex;
    print(_currentType);
    print(finalLen);
    print(sampledata.length);
    // primeira tentativa
    if (question.tentativas == 0) {
      // Certa resposta
      if (_correctAns == _selectedAns) {
        if (_currentType == 'R') {
          await _updatesGame.setForcaPlus(18, _currentIndex);
          await _updatesGame.setDataRega(_currentIndex);
          await _updatesGame.setTentativaForca(_currentIndex, 1);
        } else if (_currentType == 'E') {
          await _updatesGame.setEstrelinhas(2, _currentIndex);
          await _updatesGame.plusTentativaEstrelas(_currentIndex);
        }
        await _updateQuestions.setTentativas(_currentCode, 11, _currentIndex);
        await _updateQuestions.setUsado(_currentCode, _currentIndex);
        await _updateQuestions.setDataResposta(_currentCode, _currentIndex);
        await _updateRelatorio.setNewQuest(_currentCode, question.id!, 11);
        _numOfCorrectAns++;
      } else {
        // EEEEErrou com tentativas = 0
        await _updateQuestions.setTentativas(_currentCode, 10, _currentIndex);
        await _updateQuestions.setDataResposta(_currentCode, _currentIndex);
        if (_currentType == 'R') {
          await _updatesGame.setForcaMinus(18, _currentIndex);
        } else if (_currentType == 'E') {
          await _updatesGame.setEstrelinhas(0, _currentIndex);
        }
      }

      // Segunda tentativa
    } else if (question.tentativas == 10) {
      // Acertou de segunda
      if (_correctAns == _selectedAns) {
        if (_currentType == 'R') {
          await _updatesGame.setForcaPlus(9, _currentIndex);
          await _updatesGame.setDataRega(_currentIndex);
          await _updatesGame.setTentativaForca(_currentIndex, 1);
        } else if (_currentType == 'E') {
          await _updatesGame.setEstrelinhas(1, _currentIndex);
          await _updatesGame.plusTentativaEstrelas(_currentIndex);
        }
        await _updateQuestions.setTentativas(_currentCode, 21, _currentIndex);
        await _updateQuestions.setUsado(_currentCode, _currentIndex);
        await _updateQuestions.setDataResposta(_currentCode, _currentIndex);
        await _updateRelatorio.setNewQuest(_currentCode, question.id!, 21);
        _numOfCorrectAns++;

        // Errou de segunda
      } else {
        if (_currentType == 'R') {
          await _updatesGame.setTentativaForca(_currentIndex, 1);
          await _updatesGame.setDataRega(_currentIndex);
        } else if (_currentType == 'E') {
          await _updatesGame.plusTentativaEstrelas(_currentIndex);
        }
        await _updateQuestions.setTentativas(_currentCode, 20, _currentIndex);
        await _updateQuestions.setUsado(_currentCode, _currentIndex);
        await _updateQuestions.setDataResposta(_currentCode, _currentIndex);
        await _updateRelatorio.setNewQuest(_currentCode, question.id!, 20);
      }
    }

    _animationController.stop();
    update();

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });

    //Regar = 'R';
    //Estrelas = 'E';
  }

  void nextQuestion() {
    _isAnswered = false;
    _pageController.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    // Reset the counter
    _animationController.reset();
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
