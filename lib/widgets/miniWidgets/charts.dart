import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';
import 'package:weather_final_proj/models/weather_data.dart';
import 'package:weather_final_proj/providers/city_provider.dart';
import 'dart:developer' as dev;

class DailyTemperatureChart extends StatelessWidget {
  
  final CityProvider cityProvider;
  const DailyTemperatureChart({super.key, required this.cityProvider});

  @override
  Widget build(BuildContext context) {

    final WeatherData weatherData = cityProvider.weatherData;
    final List<double> hours = weatherData.getDailyHours();
    final List<double> temperatures = weatherData.hourly.temperature2m;
    final List<FlSpot> spots = List.generate(hours.length, (index) => FlSpot(hours[index], temperatures[index]));

    final Orientation orientation = MediaQuery.of(context).orientation;


    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
                height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.4,
                width: orientation == Orientation.portrait
                  ? double.infinity
                  : MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: WAppColor.BG_COLOR.withOpacity(0.4),
                  
                ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Daily Temperatures", style: TextStyle(color: WAppColor.PRIMARY, fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 6),
              Expanded(
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: WAppColor.SECONDARY, width: 1),
                    ),
                
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 16,
                          getTitlesWidget: (value, meta) {
                            final hour = value.toInt();
                            final hourString = (hour == 23) ? "midnight" : "$hour h";
                            return Text(hourString, 
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 8, color: WAppColor.PRIMARY, fontWeight: FontWeight.bold));
                          },
                        ),
                      ),
                
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 24,
                          getTitlesWidget: (value, meta) {
                            final temperature = value.toInt();
                            return Text('$temperature°C', 
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 8, color: WAppColor.SECONDARY, fontWeight: FontWeight.bold));
                          },
                        ),
                      ),
                
                      rightTitles:  AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 12,
                          getTitlesWidget: (value, meta) {
                            return const Text('');
                            },
                        )
                      ),
                
                      topTitles: const AxisTitles(   
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),


                      
                    ),
                   
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: WAppColor.PRIMARY_WRITE_UP,
                          strokeWidth: 0.5,
                          dashArray: [5, 5],
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: WAppColor.PRIMARY_WRITE_UP,
                          strokeWidth: 0.5,
                          dashArray: [5, 5],
                        );
                      },
                    ),
                
                   lineBarsData: [
                      LineChartBarData(
                        spots:spots,
                        isCurved: true,
                        color:WAppColor.ACCENT
                      )
                    ]
                  
                
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}



class WeeklyTemperatureChart extends StatelessWidget {
  
  final CityProvider cityProvider;
  const WeeklyTemperatureChart({super.key, required this.cityProvider});

  @override
  Widget build(BuildContext context) {

    final WeatherData weatherData = cityProvider.weatherData;
    final List<String> days = weatherData.getDays();
    final List<double> temperaturesMin = weatherData.daily.temperature2mMin;
    final List<double> temperaturesMax = weatherData.daily.temperature2mMax;
    final List<FlSpot> spotsMin = List.generate(days.length, (index) => FlSpot(index.toDouble(), temperaturesMin[index]));
    final List<FlSpot> spotsMax = List.generate(days.length, (index) => FlSpot(index.toDouble(), temperaturesMax[index]));

    dev.log("days: $days");
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
                height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.4,
                width: orientation == Orientation.portrait
                  ? double.infinity
                  : MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: WAppColor.BG_COLOR.withOpacity(0.4),
                  
                ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Weekly Temperatures", style: TextStyle(color: WAppColor.PRIMARY, fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 6),
              Expanded(
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: WAppColor.SECONDARY, width: 1),
                    ),
                
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 16,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt().toDouble() == value) {
                            final day = value.toInt();
                            
                            return Text(days[day], 
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 8, color: WAppColor.PRIMARY, fontWeight: FontWeight.bold));
                            } else {
                              return const Text('');
                            }
                          },
                        ),
                      ),
                
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 24,
                          getTitlesWidget: (value, meta) {
                            final temperature = value.toInt();
                            return Text('$temperature°C', 
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 8, color: WAppColor.SECONDARY, fontWeight: FontWeight.bold));
                          },
                        ),
                      ),
                
                      rightTitles:  AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 12,
                          getTitlesWidget: (value, meta) {
                            return const Text('');
                            },
                        )
                      ),
                
                      topTitles: const AxisTitles(   
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),


                      
                    ),
                   
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: WAppColor.PRIMARY_WRITE_UP,
                          strokeWidth: 0.5,
                          dashArray: [5, 5],
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: WAppColor.PRIMARY_WRITE_UP,
                          strokeWidth: 0.5,
                          dashArray: [5, 5],
                        );
                      },
                    ),
                
                   lineBarsData: [
                      LineChartBarData(
                        spots:spotsMin,
                        isCurved: true,
                        color:WAppColor.primarySwatch[300]
                      ),
                      LineChartBarData(
                        spots:spotsMax,
                        isCurved: true,
                        color:WAppColor.SECONDARY
                      )
                    ]
                  
                
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );





  }
}