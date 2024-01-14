import 'package:get_it/get_it.dart';
import 'package:weather_clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_architecture/data/repositories/weather_repository_impl.dart';
import 'package:weather_clean_architecture/domain/repositories/weather_repository.dart';
import 'package:weather_clean_architecture/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => http.Client());

  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));

  locator.registerLazySingleton(
      () => GetCurrentWeatherUseCase(weatherRepository: locator()));

  locator
      .registerFactory(() => WeatherBloc(getCurrentWeatherUseCase: locator()));
}
