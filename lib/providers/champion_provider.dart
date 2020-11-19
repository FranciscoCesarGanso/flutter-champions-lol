import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotation_champs/models/champion_model.dart';
import 'package:rotation_champs/models/champion_detail_model.dart';
class ChampionProvider{
  String _url="ddragon.leagueoflegends.com";

  Future <List<Champion>> _procesarRespuesta(Uri uri) async{
    final resp=await http.get(uri);
    final decodeData=json.decode(resp.body);
    final champions=new Champions.fromJsonMap(decodeData['data']); 
    return champions.items;
}   
  Future<List<Champion>>  getAll() async{
    final url= Uri.http(_url,"/cdn/10.23.1/data/en_US/champion.json");
    return await _procesarRespuesta(url);
  }

  Future<ChampionDetailedInfo> getChamp(String id) async{
  
    final url=Uri.http(_url, "/cdn/10.23.1/data/en_US/champion/$id.json");
    final resp=await http.get(url);
    final decodeData=json.decode(resp.body);
    final champ=new ChampionsDetailedInfo.fromJsonMap(decodeData['data']);
    return champ.items[0];
  }
}  
