import 'package:dental_clinic/features/presentation/pages/home/bloc/weather_bloc.dart';
import 'package:dental_clinic/features/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is Loading) {
        return LoadingWidget();
      } else if (state is Loaded) {
        return Text(state.weather.main);
      } else {
        return Container();
      }
    });
  }
}
