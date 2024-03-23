import 'package:chat/config/themes/dark_theme.dart';
import 'package:chat/config/themes/light_theme.dart';
import 'package:chat/features/global/presentations/blocs/theme_cubit.dart';
import 'package:chat/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    initializeDependencies();
  });

  Widget createWidgetUnderTest() {
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

  testWidgets(
    "Title is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text("Sign in with your email"), findsOneWidget);
    },
  );
}
