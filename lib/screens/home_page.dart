import 'package:flutter/material.dart';
import 'package:flutter_weather1/model/weather_model.dart';
import 'package:flutter_weather1/screens/additional_information.dart';
import 'package:flutter_weather1/screens/current_weather.dart';
import 'package:flutter_weather1/services/weather_api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  @override
  void initState() {
    super.initState();
    client.getCurrentWeather("London");
  }

  Future<void> getData() async {
    data = await client.getCurrentWeather("London");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
                color: Colors.white,
              ),
              SizedBox(
                width: 60.0,
              ),
              const Text(
                'Flutter',
                style: TextStyle(fontSize: 28.0),
              ),
              const Text(
                'Weather1',
                style: TextStyle(fontSize: 28.0, color: Colors.purple),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentWeather(Icons.wb_sunny_rounded, '${data!.temp}',
                      "${data!.cityName}"),
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  additionalInformation("${data!.wind}", "${data!.pressure}",
                      "${data!.humidity}", "${data!.feels_like}")
                ],
              );
            }
            return Container();
          },
        ));
  }
}
