part of "injector.dart";

final getIt = GetIt.instance;

initDep() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<Dio>(Dio());
  
  getIt.registerSingleton<ThemeBloc>(ThemeBloc());
}

final appRouter = getIt<AppRouter>();
final dio = getIt<AppRouter>();
final appData = AppData();
final sCon = SConstraint();
final network = NetworkService();

// Bloc
final themeBloc = getIt<ThemeBloc>();
