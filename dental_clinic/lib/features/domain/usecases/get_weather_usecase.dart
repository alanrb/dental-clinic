import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/weather_model.dart';
import 'package:dental_clinic/features/domain/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';

class GetWeatherUseCase implements UseCase<Weather, Param> {

  GetWeatherUseCase(this.repository);

  final WeatherRepository repository;

  @override
  Future<Either<Failure, Weather>> call(Param params) async {
    return await repository.getWeatherByCity(params.cityName);
  }
}

class Param extends Equatable {
  Param({required this.cityName});

  final String cityName;

  @override
  List<Object?> get props => [cityName];
}
