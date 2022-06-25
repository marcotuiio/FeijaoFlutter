class QuestionModel {
  List<Questoes>? questoes;

  QuestionModel({this.questoes});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json['questoes'] != null) {
      questoes = <Questoes>[];
      json['questoes'].forEach((v) {
        questoes!.add(Questoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questoes != null) {
      data['questoes'] = questoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questoes {
  int? tentativas;
  int? id;
  String? question;
  List<String>? options;
  int? answerIndex;
  String? comentario;

  Questoes(
      {this.tentativas,
      this.id,
      this.question,
      this.options,
      this.answerIndex,
      this.comentario});

  Questoes.fromJson(Map<String, dynamic> json) {
    tentativas = json['tentativas'];
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    answerIndex = json['answer_index'];
    comentario = json['comentário'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tentativas'] = tentativas;
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['answer_index'] = answerIndex;
    data['comentário'] = comentario;
    return data;
  }
}
