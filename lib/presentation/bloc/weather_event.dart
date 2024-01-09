import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class OnCityChanged extends WeatherEvent {
  final String cityName;
  OnCityChanged({
    required this.cityName,
  });

  @override
  List<Object?> get props => [cityName];
}
