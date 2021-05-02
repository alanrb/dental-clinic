import 'package:connectivity/connectivity.dart';
import 'package:dental_clinic/core/network/network_info.dart';
import 'package:dental_clinic/features/data/repositories/appointment_repository_firebase_impl.dart';
import 'package:dental_clinic/features/data/repositories/user_repository_firebase_impl.dart';
import 'package:dental_clinic/features/data/repositories/weather_repository_impl.dart';
import 'package:dental_clinic/features/domain/repositories/appointment_repository.dart';
import 'package:dental_clinic/features/domain/repositories/user_repository.dart';
import 'package:dental_clinic/features/domain/repositories/weather_repository.dart';
import 'package:dental_clinic/features/domain/usecases/create_appointment_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/get_doctor_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/get_issue_case_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/get_user_appointment_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/get_weather_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/user/get_user_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/user/register_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/user/sign_in_with_credentials_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/user/signout_usecase.dart';
import 'package:dental_clinic/features/presentation/pages/appointment/bloc/appointment_form_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/home/bloc/recent_appointment_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/home/bloc/weather_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/authentication_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/login_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => WeatherBloc(sl()));
  sl.registerFactory(() => AppointmentFormBloc(sl(), sl(), sl()));
  sl.registerFactory(() => RecentAppointmentBloc(sl()));
  sl.registerFactory(() => AuthenticationBloc(sl(), sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => RegisterBloc(sl()));

  // Use case
  sl.registerLazySingleton(() => GetWeatherUseCase(sl()));
  sl.registerLazySingleton(() => AddAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => GetIssueCaseUseCase(sl()));
  sl.registerLazySingleton(() => GetDoctorUseCase(sl()));
  sl.registerLazySingleton(() => GetUserAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithCredentialsUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryFirebaseImpl());
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryFirebaseImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
