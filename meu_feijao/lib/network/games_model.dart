class GamesModel {
  List<Jogos>? jogos;

  GamesModel({this.jogos});

  GamesModel.fromJson(Map<String, dynamic> json) {
    if (json['jogos'] != null) {
      jogos = <Jogos>[];
      json['jogos'].forEach((v) {
        jogos!.add(Jogos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jogos != null) {
      data['jogos'] = jogos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jogos {
  String? codigo;
  String? nomeFantasia;
  String? disciplina;
  String? professor;
  String? datainicio;
  String? datafim;
  String? forca;
  String? dataAtualizacaoForca;
  String? qtdEstrelinhas;

  Jogos(
      {this.codigo,
      this.nomeFantasia,
      this.disciplina,
      this.professor,
      this.datainicio,
      this.datafim,
      this.forca,
      this.dataAtualizacaoForca,
      this.qtdEstrelinhas});

  Jogos.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    nomeFantasia = json['nome_fantasia'];
    disciplina = json['disciplina'];
    professor = json['professor'];
    datainicio = json['datainicio'];
    datafim = json['datafim'];
    forca = json['forca'];
    dataAtualizacaoForca = json['dataAtualizacaoForca'];
    qtdEstrelinhas = json['qtd_estrelinhas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nome_fantasia'] = nomeFantasia;
    data['disciplina'] = disciplina;
    data['professor'] = professor;
    data['datainicio'] = datainicio;
    data['datafim'] = datafim;
    data['forca'] = forca;
    data['dataAtualizacaoForca'] = dataAtualizacaoForca;
    data['qtd_estrelinhas'] = qtdEstrelinhas;
    return data;
  }
}