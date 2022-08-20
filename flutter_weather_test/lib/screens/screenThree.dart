//  прогноз на 5 дней с интервалом 3 часа по названию города
//api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/bloc/weatherEvent.dart';
import 'package:flutter_weather_test/entities/WeatherFiveDays.dart';
import 'package:flutter_weather_test/screens/screenOne.dart';

import '../bloc/weatherBloc.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherBloc bloc = context.read<WeatherBloc>();
    String cityName = controller.text;
    final weather = fetchCityFiveDaysWeather(cityName);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            bloc.add(MyInitialEvent());
          },
        ),
        leadingWidth: 100,
        title: const Text('Погода на три дня'),
        titleSpacing: 20,
      ),
      body: FutureBuilder<CityWeatherFiveDays>(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListView.builder(
                    itemCount: 3, // weather.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Дата:'),
                              Text((snapshot
                                      .data!.list[checkLabel(index)].dtTxt)
                                  .toString()), //'${snapshot.data!.main.temp}C'
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Температура воздуха:'),
                              Text(
                                  '${snapshot.data!.list[checkLabel(index)].main.tempMax} С'), //'${snapshot.data!.main.temp}C'
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Скорость ветра'),
                              Text(
                                  '${snapshot.data!.list[checkLabel(index)].wind.speed}  Км/ч'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Влажность:'),
                              Text(
                                  '${snapshot.data!.list[checkLabel(index)].main.humidity} %'), //'${snapshot.data!.main.humidity}%'
                            ],
                          ),
                        ]),
                      );
                    }),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

int checkLabel(int index) {
  int label = 8;
  switch (index) {
    case 0:
      return label;
    case 1:
      return label + 8;
    case 2:
      return label + 16;
    default:
      return label;
  }
}
