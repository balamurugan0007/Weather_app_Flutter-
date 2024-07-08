import 'package:flutter/material.dart';

class Mainwidget extends StatelessWidget {
  final location;
  final temp;
  final tempmin;
  final weather;
  final humidity;

  Weatherinfo({
    required this.location;
    required this.temp;
    required this.tempmin;
    required this.tempmax;
    required this.weather;
    required this.humidity;
    required this.windspeed;
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            Text(
              '${location}', style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ) ,
            )
          ),
        )
      ],
    );
  }
}
