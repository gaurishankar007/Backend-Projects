import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'config/routes/routes.dart';
import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';
import 'core/utils/screen.dart';
import 'features/global/presentations/blocs/theme_cubit.dart';
import 'initializer.dart';

Future<void> main() async {
  await Initializer.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Screen.setScreen(constraints, context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => GetIt.I<ThemeCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Chat App',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: state.themeMode,
                routerDelegate: GetIt.I<AppRouter>().delegate(),
                routeInformationParser: GetIt.I<AppRouter>().defaultRouteParser(),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      },
    );
  }
}
