class RelatorioModel {
  List<Quests>? quests;

  RelatorioModel({this.quests});

  RelatorioModel.fromJson(Map<String, dynamic> json) {
    if (json['quests'] != null) {
      quests = <Quests>[];
      json['quests'].forEach((v) {
        quests!.add(Quests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quests != null) {
      data['quests'] = quests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quests {
  int? tentativas;
  int? id;

  Quests({this.tentativas, this.id});

  Quests.fromJson(Map<String, dynamic> json) {
    tentativas = json['tentativas'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tentativas'] = tentativas;
    data['id'] = id;
    return data;
  }
}
