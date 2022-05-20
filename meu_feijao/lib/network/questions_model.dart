class QuestionsModel {
  List<Questao>? questao;

  QuestionsModel({this.questao});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['questao'] != null) {
      questao = <Questao>[];
      json['questao'].forEach((v) {
        questao!.add(Questao.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questao != null) {
      data['questao'] = questao!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questao {
  String? idQuestao;
  String? enunciado;
  String? respCorreta;
  String? comentario;
  List<Respostas>? respostas;

  Questao(
      {this.idQuestao,
      this.enunciado,
      this.respCorreta,
      this.comentario,
      this.respostas});

  Questao.fromJson(Map<String, dynamic> json) {
    idQuestao = json['id_questao'];
    enunciado = json['enunciado'];
    respCorreta = json['resp_correta'];
    comentario = json['comentario'];
    if (json['respostas'] != null) {
      respostas = <Respostas>[];
      json['respostas'].forEach((v) {
        respostas!.add(Respostas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_questao'] = idQuestao;
    data['enunciado'] = enunciado;
    data['resp_correta'] = respCorreta;
    data['comentario'] = comentario;
    if (respostas != null) {
      data['respostas'] = respostas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Respostas {
  String? idResp;
  String? texto;

  Respostas({this.idResp, this.texto});

  Respostas.fromJson(Map<String, dynamic> json) {
    idResp = json['id_resp'];
    texto = json['texto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_resp'] = idResp;
    data['texto'] = texto;
    return data;
  }
}
