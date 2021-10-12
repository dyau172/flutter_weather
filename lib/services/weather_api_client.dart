import 'dart:convert';

import 'package:flutter_weather1/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=813e3a9b93bdb7cd510452b0e49af603&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
