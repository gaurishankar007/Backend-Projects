import 'features/global/presentations/blocs/theme_cubit.dart';
import 'injection/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appData.initialize();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screenSize.init(constraints);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => themeCubit),
            BlocProvider(create: (_) => authCubit),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Chat App',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: state.themeMode,
                routerDelegate: appRouter.delegate(),
                routeInformationParser: appRouter.defaultRouteParser(),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      },
    );
  }
}
