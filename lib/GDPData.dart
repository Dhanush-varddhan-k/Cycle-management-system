class GDPData{
  GDPData(this.continent,this.gdp);
  final String continent;
  final int gdp;
  factory GDPData.fromJson(Map<String,dynamic> parsedJson){
    return GDPData(parsedJson["continent"].toString(), parsedJson["gdp"]);
  }
}