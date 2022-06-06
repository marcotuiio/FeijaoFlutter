// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:feijao_magico_uel/network/games_model.dart';
import 'package:http/http.dart';

class NetworkGame {
  Future<GamesModel> getGamesModel({required String gameCode}) async {
    // var url = "api do server"+gameCode; //integrar com o server
    var url = "https://marcotuiio.github.io/Data/"+gameCode+".json";
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      //aqui eu ja tenho todo o json em formato de mapa (dart object) !!!
      print(response.body);
      return GamesModel.fromJson(json.decode(response.body)); 
    } else {
      throw Exception("ERRO AO OBTER URL");
    }
  }
} 
