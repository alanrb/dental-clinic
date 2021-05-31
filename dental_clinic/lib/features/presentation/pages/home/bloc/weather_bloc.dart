import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/features/domain/model/weather_model.dart';
import 'package:dental_clinic/features/domain/usecases/get_weather_usecase.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NETWORK_FAILURE_MESSAGE = 'No Internet connection';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final GetWeatherUseCase getWeatherUseCase;

  WeatherBloc(this.getWeatherUseCase) : super(Empty());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherByCity) {
      yield Loading();
      final failureOrResult = await getWeatherUseCase(Param(cityName: event.cityName));
      yield failureOrResult.fold((failure) => Error(message: _mapFailureToMessage(failure)),
              (weather) => Loaded(weather: weather));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
