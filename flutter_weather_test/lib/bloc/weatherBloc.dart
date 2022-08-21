import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_test/entities/CityWeather.dart';
import 'package:flutter_weather_test/entities/WeatherFiveDays.dart';
import 'package:flutter_weather_test/screens/screenOne.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/bloc/weatherEvent.dart';
import 'package:flutter_weather_test/bloc/weatherState.dart';

//описание состояний
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

//метод возвращает погоду по названию города
Future<CityWeather> fetchCityWeather(String cityName) async {
  final response = await http.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=32bf6b8b7e57203605e76010ac3c14c6&units=metric&lang=ru'),
  );
  final statusCode = response.statusCode;
  if (statusCode != 200) {
    throw Exception("An error occured : [Status Code : $statusCode]");
  }
  final responseJson = await json.decode(response.body);

  return CityWeather.fromJson(responseJson);
}

//метод возвращает погоду по названию города прогноз на 5 дней с метками каждые 3 часа
Future<CityWeatherFiveDays> fetchCityFiveDaysWeather(String cityName) async {
  final response = await http.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=32bf6b8b7e57203605e76010ac3c14c6&units=metric&lang=ru'),
  );

  final responseJson = await json.decode(response.body);

  return CityWeatherFiveDays.fromJson(responseJson);
}
