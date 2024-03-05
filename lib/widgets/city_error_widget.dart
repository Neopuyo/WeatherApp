import 'package:flutter/material.dart';
import 'package:weather_final_proj/models/city_class.dart';


class CityErrorWidget extends StatelessWidget {

  final CityError error;
  const CityErrorWidget({super.key, required this.error});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          ElevatedButton(
            onPressed: error.onTap,
            child: const Text("ok"),
          ),
        ],
      ),
    );
  }


}

class CityErrorVirginWidget extends StatelessWidget {

  final String message;
  const CityErrorVirginWidget({super.key, required this.message});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}