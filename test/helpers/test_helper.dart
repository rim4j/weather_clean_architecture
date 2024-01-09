import 'package:weather_clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_architecture/domain/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather_clean_architecture/domain/usecases/get_current_weather_usecase.dart';

@GenerateMocks([
  WeatherRepository,
  WeatherRemoteDataSource,
  GetCurrentWeatherUseCase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
