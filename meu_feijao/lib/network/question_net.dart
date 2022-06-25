import 'dart:convert';
import 'package:feijao_magico_uel/network/questions_model.dart';
import 'package:http/http.dart';

class NetworkQuestion {
  Future<QuestionModel> getQuestionModel({required String gameCode}) async {
    var url =
        "https://marcotuiio.github.io/Data/questions_" + gameCode + ".json";
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      //aqui eu ja tenho todo o json em formato de mapa (dart object) !!!
      return QuestionModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("ERRO AO OBTER URL");
    }
  }
}
