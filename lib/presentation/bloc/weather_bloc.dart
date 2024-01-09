// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:weather_clean_architecture/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_clean_architecture/presentation/bloc/weather_event.dart';
import 'package:weather_clean_architecture/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  WeatherBloc({
    required this.getCurrentWeatherUseCase,
  }) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await getCurrentWeatherUseCase(event.cityName);

        result.fold((fail) {
          emit(WeatherLoadFailure(message: fail.message));
        }, (data) {
          emit(WeatherLoaded(result: data));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
