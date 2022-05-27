class GamesModel {
  List<Jogos>? jogos;

  GamesModel({this.jogos});

  GamesModel.fromJson(Map<String, dynamic> json) {
    if (json['jogos'] != null) {
      jogos = <Jogos>[];
      json['jogos'].forEach((v) {
        jogos!.add(new Jogos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jogos != null) {
      data['jogos'] = this.jogos!.map((v) => v.toJson()).toList();
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
  int? forca;
  String? dataAtualizacaoForca;
  int? qtdEstrelinhas;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['nome_fantasia'] = this.nomeFantasia;
    data['disciplina'] = this.disciplina;
    data['professor'] = this.professor;
    data['datainicio'] = this.datainicio;
    data['datafim'] = this.datafim;
    data['forca'] = this.forca;
    data['dataAtualizacaoForca'] = this.dataAtualizacaoForca;
    data['qtd_estrelinhas'] = this.qtdEstrelinhas;
    return data;
  }
}
