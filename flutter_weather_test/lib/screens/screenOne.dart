import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/bloc/weatherBloc.dart';
import 'package:flutter_weather_test/bloc/weatherEvent.dart';

final TextEditingController contentController = TextEditingController();

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

final controller = TextEditingController();
late String cityName;

class _ScreenOneState extends State<ScreenOne> {
  _handleText() {
    //считываем текст введенный пользователем и сохраняем в переменную
    cityName = controller.text;
  }

  @override
  void initState() {
    controller.addListener(_handleText);
  }

  @override
  Widget build(BuildContext context) {
    final WeatherBloc bloc = context.read<WeatherBloc>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 70,
              width: 200,
              //форма ввода названия города
              child: TextFormField(
                controller: controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Введите город",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 200,
              //кнопка перехода на экран2
              child: OutlinedButton(
                  child: const Text('Подтвердить'),
                  onPressed: () {
                    bloc.add(ScreenTwoEvent());
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
