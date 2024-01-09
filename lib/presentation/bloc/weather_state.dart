import 'package:equatable/equatable.dart';

import 'package:weather_clean_architecture/domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {}

class WeatherEmpty extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;
  WeatherLoaded({
    required this.result,
  });

  @override
  List<Object?> get props => [result];
}

class WeatherLoadFailure extends WeatherState {
  final String message;

  WeatherLoadFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
