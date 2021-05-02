import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  final String main;
  final String description;
  final String icon;

  Weather({required this.main, required this.description, required this.icon});

  @override
  List<Object?> get props => [main, description, icon];

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

class WeatherList {
  List<Weather> weathers;

  WeatherList({required this.weathers});

  factory WeatherList.fromJson(List<dynamic> json) {
    return WeatherList(weathers: json.map((e) => Weather.fromJson(e)).toList());
  }
}
