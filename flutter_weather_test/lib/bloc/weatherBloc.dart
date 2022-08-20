import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_test/entities/CityWeather.dart';
import 'package:flutter_weather_test/entities/WeatherFiveDays.dart';
import 'package:flutter_weather_test/screens/screenOne.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/bloc/weatherEvent.dart';
import 'package:flutter_weather_test/bloc/weatherState.dart';

class WeatherBloc extends Bloc<MyEvent, MyState> {
  WeatherBloc() : super(MyInitialState()) {
    on<MyInitialEvent>((event, emit) async {
      emit(MyInitialState());
    });
    on<ScreenTwoEvent>((event, emit) async {
      emit(ScreenTwoState(cityName: controller.text));
    });
    on<ScreenThreeEvent>((event, emit) async {
      emit(ScreenThreeState(cityName: controller.text));
    });
  }
}

// по городу   https://api.openweathermap.org/data/2.5/weather?q=London&appid=32bf6b8b7e57203605e76010ac3c14c6&units=metric

Future<CityWeather> fetchCityWeather(String cityName) async {
  final response = await http
      .get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=32bf6b8b7e57203605e76010ac3c14c6&units=metric'),
  )
      .catchError((error) {
    print('Error');
  });
  final responseJson = await json.decode(response.body);

  return CityWeather.fromJson(responseJson);
}

Future<CityWeatherFiveDays> fetchCityFiveDaysWeather(String cityName) async {
  //api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=32bf6b8b7e57203605e76010ac3c14c6&units=metric'),
  final response = await http.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=32bf6b8b7e57203605e76010ac3c14c6&units=metric'),
  );
  final responseJson = await json.decode(response.body);
  final listresponse = CityWeatherFiveDays.fromJson(responseJson).list;
  return CityWeatherFiveDays.fromJson(responseJson);
}
