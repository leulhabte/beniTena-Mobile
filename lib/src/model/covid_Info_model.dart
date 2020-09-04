class CovidInfoModel {
  static int recovered;
  static int deaths;
  static int confirmed;
  static String lastChecked;
  static String lastReported;
  static String location;
  static String country;

  CovidInfoModel.fromJson(Map<String, dynamic> jsonData){
      recovered = jsonData['recovered'];
      deaths = jsonData['deaths'];
      confirmed = jsonData['confirmed'];
      lastChecked = jsonData['lastChecked'];
      lastReported = jsonData['lastReported'];
      location = jsonData['location'];
  }

  static Map<String, dynamic> getJsonData(){
    return<String, dynamic>{
      "recovered": recovered,
      "deaths": deaths,
      "confirmed": confirmed,
      "lastChecked": lastChecked,
      "lastReported": lastReported,
      "location":location
    };
  }

}