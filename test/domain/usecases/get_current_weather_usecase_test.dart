import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture/domain/entities/weather_entity.dart';
import 'package:weather_clean_architecture/domain/usecases/get_current_weather_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: "new york",
    main: "clouds",
    description: "few clouds",
    iconCode: "02d",
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = "new york";

  test("should get current weather detail from the repository", () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    //act
    final result = await getCurrentWeatherUseCase(testCityName);

    //assert
    expect(result, const Right(testWeatherDetail));
  });
}
