import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/bloc/weatherBloc.dart';
import 'package:flutter_weather_test/bloc/weatherState.dart';
import 'package:flutter_weather_test/screens/screenOne.dart';
import 'package:flutter_weather_test/screens/screenThree.dart';
import 'package:flutter_weather_test/screens/screenTwo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
            create: (BuildContext context) => WeatherBloc(),
            child: const MainScreen()));
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, MyState>(builder: (context, state) {
      if (state is MyInitialState) {
        return const ScreenOne();
      }
      if (state is ScreenTwoState) {
        return ScreenTwo(cityName: state.cityName);
      }
      if (state is ScreenThreeState) {
        return const ScreenThree();
      } else {
        return const Text('Error');
      }
    });
  }
}
