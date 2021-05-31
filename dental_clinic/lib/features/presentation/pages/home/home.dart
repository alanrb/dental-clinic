import 'package:auto_route/auto_route.dart';
import 'package:dental_clinic/features/presentation/pages/appointment/appointment.dart';
import 'package:dental_clinic/features/presentation/pages/home/bloc/recent_appointment_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/home/bloc/weather_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/home/widgets/appointment_widget.dart';
import 'package:dental_clinic/features/presentation/pages/home/widgets/home_user_info_widget.dart';
import 'package:dental_clinic/features/presentation/pages/home/widgets/weather_widget.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/authentication_bloc.dart';
import 'package:dental_clinic/features/presentation/routes/router.gr.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherByCity('Ho Chi Minh'));
    BlocProvider.of<RecentAppointmentBloc>(context).add(LoadRecent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dental Clinic'),
        actions: <Widget>[_buildAppbarActions(context)],
      ),
      body: CustomScrollView(slivers: [
        SliverPadding(
            padding: Styles.space_m,
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return WeatherInfo();
              } else if (index == 1) {
                return HomeUserInfoWidget();
              } else {
                return Image.asset('assets/dental_clinic.jpg');
              }
            }, childCount: 3))),
        BlocBuilder<RecentAppointmentBloc, RecentAppointmentState>(
            builder: (context, state) {
          if (state is AppointmentLoaded && state.cases.length > 0) {
            return SliverPadding(
                padding: Styles.space_m,
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return RecentAppointment(datum: state.cases);
                }, childCount: 1)));
          } else {
            return SliverPadding(
                padding: Styles.space_m,
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return SizedBox(height: Styles.space.bottom);
                }, childCount: 1)));
          }
        })
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _makeAppointment(context),
          label: Text('Appointment'),
          icon: Icon(Icons.calendar_today_outlined)),
    );
  }

  void _makeAppointment(BuildContext context) {
    if (BlocProvider.of<AuthenticationBloc>(context).state is Authenticated) {
      Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => MakeAppointmentPage(), fullscreenDialog: true));
    } else {
      AutoRouter.of(context).navigate(LoginRoute());
    }
  }
}

Widget _buildAppbarActions(BuildContext context) {
  return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
    if (state is Authenticated) {
      return IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Logout'),
                          content: Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Remain Signed In'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                              },
                              child: Text('Yes, Logout'),
                            ),
                          ],
                        ))
              });
    } else {
      return IconButton(
          icon: Icon(Icons.person),
          onPressed: () => {AutoRouter.of(context).navigate(LoginRoute())});
    }
  });
}
