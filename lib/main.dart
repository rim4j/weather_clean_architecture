import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_architecture/injection_container.dart';
import 'package:weather_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:weather_clean_architecture/presentation/pages/weather_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WeatherBloc>(),
        ),
      ],
      child: const MaterialApp(
        title: 'Weather clean architecture',
        debugShowCheckedModeBanner: false,
        home: WeatherPage(),
      ),
    );
  }
}
