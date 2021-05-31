import 'package:dental_clinic/bloc_observer.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/register_bloc.dart';
import 'package:dental_clinic/features/presentation/routes/router.gr.dart'
    as app_router;
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/pages/appointment/bloc/appointment_form_bloc.dart';
import 'features/presentation/pages/home/bloc/recent_appointment_bloc.dart';
import 'features/presentation/pages/home/bloc/weather_bloc.dart';
import 'features/presentation/pages/login/bloc/authentication_bloc.dart';
import 'features/presentation/pages/login/bloc/login_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = app_router.AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => sl<AuthenticationBloc>()..add(AppStarted())),
          BlocProvider(create: (_) => sl<WeatherBloc>()),
          BlocProvider(create: (_) => sl<AppointmentFormBloc>()),
          BlocProvider(create: (_) => sl<RecentAppointmentBloc>()),
          BlocProvider(create: (_) => sl<LoginBloc>()),
          BlocProvider(create: (_) => sl<RegisterBloc>())
        ],
        child: MaterialApp(
          title: 'Dental Clinic',
          theme: Styles.primaryTheme(context),
          home: MaterialApp.router(
              routeInformationParser: _appRouter.defaultRouteParser(),
              routerDelegate: _appRouter.delegate()),
        ));

    // return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider.value(value: ApplicationState()),
    //     ],
    //     child: MaterialApp(
    //       title: 'Dental Clinic',
    //       theme: Styles.primaryTheme(context),
    //       home: MaterialApp.router(
    //           routeInformationParser: _appRouter.defaultRouteParser(),
    //           routerDelegate: _appRouter.delegate()),
    //     ));
  }
}
