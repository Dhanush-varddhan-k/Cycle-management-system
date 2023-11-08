import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:http/http.dart";
import "package:flutter/services.dart" show rootBundle;

import 'GDPData.dart';
class Piechart extends StatefulWidget {
  const Piechart({Key? key}) : super(key: key);
  @override
  State<Piechart> createState() => _PiechartState();
}

class _PiechartState extends State<Piechart> {

  Future<String> getJsonFromAssets() async {
    return await rootBundle.loadString("assets/data.json");
  }

  Future loadSalesData() async {
    final String jsonString = await getJsonFromAssets();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      print("i $i");
      chart.add(GDPData.fromJson(i));
    }
  }

  List<GDPData> chart = [];
  TooltipBehavior? tooltipBehavior;

  @override
  void initState() {
    loadSalesData();
    super.initState();
    //chart=getChartData();
    tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 200,
        width:500,
        padding:EdgeInsets.all(20),
        child: FutureBuilder(
          future: getJsonFromAssets(),
          // Replace with your actual function that loads JSON data
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading, you can show a loading indicator or message
              return const CircularProgressIndicator(); // Replace with your loading widget
            } else if (snapshot.hasError) {
              // If there's an error during data loading, handle the error here
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Once data is loaded, you can access it from snapshot.data
              //Map<String, dynamic> jsonData = snapshot.data;
              print("chart is $chart");
              // Now, you can build your UI using the loaded data
              return SfCircularChart(
                  title: ChartTitle(text: "continent wise gdp"),
                  legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  tooltipBehavior: tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<GDPData, String>(
                      dataSource: chart,
                      xValueMapper: (GDPData data, _) => data.continent,
                      yValueMapper: (GDPData data, _) => data.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                    )
                  ]
              ); // Replace with your UI widget
            } else {
              // By default, show a placeholder or fallback widget
              return Text('No data available');
            }
          },
        ),
      );
  }
}