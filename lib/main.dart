import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';
import 'features/global/presentations/blocs/theme_cubit.dart';
import 'injector/injector.dart';

Future<void> main() async {
  await initializer.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screen.initializeScreen(constraints, context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => themeCubit),
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
