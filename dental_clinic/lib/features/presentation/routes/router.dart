import 'package:auto_route/annotations.dart';
import 'package:dental_clinic/features/presentation/pages/appointment/appointment.dart';
import 'package:dental_clinic/features/presentation/pages/home/home.dart';
import 'package:dental_clinic/features/presentation/pages/login/login.dart';
import 'package:dental_clinic/features/presentation/pages/login/register.dart';

// flutter packages pub run build_runner build

@MaterialAutoRouter(
    replaceInRouteName: 'Page,Route',
    routes: <AutoRoute>[
      AutoRoute(page: HomePage, initial: true),
      AutoRoute(page: MakeAppointmentPage),
      AutoRoute(page: LoginPage),
      AutoRoute(page: RegisterPage)
    ]
)
class $AppRouter {

}