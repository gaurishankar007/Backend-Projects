part of "injector.dart";

final getIt = GetIt.instance;

initDep() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<Dio>(Dio());
}

final appRouter = getIt<AppRouter>();
final dio = getIt<AppRouter>();
final appData = AppData();
final sCon = SConstraint();
final network = NetworkService();
