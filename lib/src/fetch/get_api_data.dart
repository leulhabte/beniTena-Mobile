import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/covid_Info_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CovidInfo{
  static Future<dynamic> getGlobal() async{
    try{
      var res = await http.get('https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/total',
        headers: {
          'content-type':'application/octet-stream',
          'x-rapidapi-host':'covid-19-coronavirus-statistics.p.rapidapi.com',
          'x-rapidapi-key':'9214729ffemsh878f61adb83658fp1c2b1ejsn6014ee49d429',
          'useQueryString': 'true'
        },
      );
      if(res.statusCode == 200){
        var jsonData = json.decode(res.body);
        CovidInfoModel.fromJson(jsonData['data']);
        var mapData = CovidInfoModel.getJsonData();
        return mapData;
      }

      return 0;
    }catch(err){
      return 1;
    }
  }

  static Future<dynamic> getCountry() async{
    try{
      var res = await http.get('https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/total?country=Ethiopia',
          headers: {
            'content-type':'ap  plication/octet-stream',
            'x-rapidapi-host':'covid-19-coronavirus-statistics.p.rapidapi.com',
            'x-rapidapi-key': '${DotEnv().env['RAPID_API_KEY']}',
            'useQueryString': 'true'
          }
      );
      if(res.statusCode == 200){
        var jsonData = json.decode(res.body);
        CovidInfoModel.fromJson(jsonData['data']);
        var mapData = CovidInfoModel.getJsonData();
        return mapData;
      }

      return 0;
    }catch(err){
      return 1;
    }
  }
}