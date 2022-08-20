import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/bloc/weatherBloc.dart';
import 'package:flutter_weather_test/bloc/weatherEvent.dart';
import 'package:flutter_weather_test/entities/CityWeather.dart';
import 'package:flutter_weather_test/screens/screenOne.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({Key? key, required cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherBloc bloc = context.read<WeatherBloc>();
    String cityName = controller.text;

    final weather = fetchCityWeather(cityName);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            bloc.add(MyInitialEvent());
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                bloc.add(ScreenThreeEvent());
              },
              icon: const Icon(Icons.info))
        ],
        leadingWidth: 100,
        title: const Text('Погода'),
        titleSpacing: 80,
      ),
      body: FutureBuilder<CityWeather>(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(cityName), //?? 'London'
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Температура воздуха:'),
                        Text('${snapshot.data!.main.temp}C'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Скорость ветра'),
                        Text('${snapshot.data!.wind.speed}Км/ч'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Влажность:'),
                        Text('${snapshot.data!.main.humidity}%'),
                      ],
                    ),
                  ]);
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
