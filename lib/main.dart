import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/Models/weather.dart';

void main() {
  runApp(MaterialApp(
    title: 'weather app',
    home: Myapp(),
  ));
}

class City {
  final String place;
  final String zipcode;

  City({
    required this.place,
    required this.zipcode,
  });
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List city = [
    City(place: 'Chennai', zipcode: '600001'),
    City(place: 'Tenampet West', zipcode: '600006'),
    City(place: 'Egmore', zipcode: '600008'),
    City(place: 'Medavakkam', zipcode: '600010'),
    City(place: 'Perambur', zipcode: '600011'),
    City(place: 'Kk Nagar', zipcode: '620021'),
    City(place: 'Chennai Airport', zipcode: '600016'),
    City(place: 'Thennur', zipcode: '620017'),
    City(place: 'Lalgudi', zipcode: '621601'),
  ];

  Future<Weather> fetchdata(zip) async {
    final Zipcode = zip;
    final apikey = '92e4be89b2ba804de87bb9d2a9f91875';
    final requesturl =
        'https://api.openweathermap.org/data/2.5/weather?zip=$Zipcode,IN&appid=$apikey';
    final response = await http.get(Uri.parse(requesturl));

    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      return Weather.json(weatherData);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  late Future<Weather> _weatherFuture;

  void initState() {
    super.initState();
    String ZipcodeVal = '600002';
    _weatherFuture = fetchdata(ZipcodeVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Center(
            child: Text(
              'Check Weather Report',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            child: Image(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/4e/10/93/4e1093eab91fdf4d42788a97d3440ccd.jpg')),
          ),
          Container(
            child: FutureBuilder<Weather>(
              future: _weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final weather = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weather.city,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${weather.temp}°C',
                        style: TextStyle(fontSize: 48),
                      ),
                      SizedBox(height: 8),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Min: ${weather.mintemp}°C ',
                            style:
                                TextStyle(fontSize: 16, color: Colors.purple),
                          ),
                          Text(
                            ' | Max: ${weather.maxtemp}°C',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ],
                      ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'See Another City',
            style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: city.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                        width: 100,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        color: Colors.blue,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              print('${city[i].zipcode}');
                              setState(() {
                                // ZipcodeVal = '${city[i].zipcode}';
                                String ZipcodeVal = '${city[i].zipcode}';
                                _weatherFuture = fetchdata(ZipcodeVal);
                              });
                            },
                            child: Text(
                              '${city[i].place}',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ));
                  })),
        ],
      ),
    ));
  }
}
