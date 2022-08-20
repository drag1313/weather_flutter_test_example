import 'package:flutter/material.dart';

@immutable
abstract class MyState {
  String? cityName;
  MyState({this.cityName});
}

class MyInitialState extends MyState {}

class ScreenTwoState extends MyState {
  ScreenTwoState({super.cityName});
}

class ScreenThreeState extends MyState {
  ScreenThreeState({super.cityName});
}
