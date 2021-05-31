import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/exceptions.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/network/network_info.dart';
import 'package:dental_clinic/features/domain/model/weather_model.dart';
import 'package:dental_clinic/features/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

const String API_KEY = 'd30d7e3341272983cfb2a378c00c15a1';

class WeatherRepositoryImpl implements WeatherRepository {
  final http.Client client;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl(this.client, this.networkInfo);

  @override
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName) async {
    if (await networkInfo.isConnected) {

      final response = await client.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API_KEY'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var weatherMap = json.decode(response.body)['weather'];
        var weatherList = WeatherList.fromJson(weatherMap);
        return Right(weatherList.weathers.first);
      } else {
        throw Left(ServerException(response.body.toString()));
      }
    } else {
      throw Left(NetworkException());
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw ServerException(response.body.toString());
      case 401:
      case 403:
        throw UnAuthorisedException();
      case 500:
      default:
        throw UnKnownException();
    }
  }
}
