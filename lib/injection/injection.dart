part of "injector.dart";

final getIt = GetIt.instance;

initDependencies() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<ThemeCubit>(ThemeCubit());
  getIt.registerSingleton<AuthCubit>(AuthCubit());
}

final appRouter = getIt<AppRouter>();
final dio = getIt<Dio>();
final appData = AppData();
final sCon = SConstraint();
final network = NetworkService();

// Bloc
final themeCubit = getIt<ThemeCubit>();
final authCubit = getIt<AuthCubit>();
