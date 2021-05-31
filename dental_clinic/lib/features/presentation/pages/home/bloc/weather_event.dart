part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherByCity extends WeatherEvent {
  final String cityName;

  GetWeatherByCity(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
