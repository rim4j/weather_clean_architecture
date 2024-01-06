import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/exeption.dart';

import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_architecture/domain/entities/weather_entity.dart';
import 'package:weather_clean_architecture/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
