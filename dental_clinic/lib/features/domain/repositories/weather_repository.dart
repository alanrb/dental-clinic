
import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/features/domain/model/weather_model.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName);

}