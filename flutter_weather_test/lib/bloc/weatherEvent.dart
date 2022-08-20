import 'package:flutter/material.dart';

@immutable
abstract class MyEvent {}

class MyInitialEvent extends MyEvent {}

class ScreenTwoEvent extends MyEvent {}

class ScreenThreeEvent extends MyEvent {}
