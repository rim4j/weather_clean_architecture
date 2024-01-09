import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';

import 'package:weather_clean_architecture/domain/entities/weather_entity.dart';
import 'package:weather_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:weather_clean_architecture/presentation/bloc/weather_event.dart';
import 'package:weather_clean_architecture/presentation/bloc/weather_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc =
        WeatherBloc(getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase);
  });
  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test("initial state should be empty", () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUseCase(testCityName))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(OnCityChanged(cityName: testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      WeatherLoaded(result: testWeather),
    ],
  );

  blocTest(
      "should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful",
      build: () {
        when(mockGetCurrentWeatherUseCase(testCityName)).thenAnswer(
          (_) async => const Left(ServerFailure("server failure")),
        );
        return weatherBloc;
      },
      act: (bloc) => bloc.add(OnCityChanged(cityName: testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            WeatherLoadFailure(message: "server failure"),
          ]);
}
