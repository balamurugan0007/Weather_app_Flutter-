  final Zipcode = '600001';
    final apikey = '92e4be89b2ba804de87bb9d2a9f91875';
    final requesturl =
        'https://api.openweathermap.org/data/2.5/weather?zip=$Zipcode,IN&appid=$apikey';

    final response = await http.get(Uri.parse(requesturl));