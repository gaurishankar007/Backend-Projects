import 'package:chat/config/routes/routes.dart';
import 'package:chat/config/themes/dark_theme.dart';
import 'package:chat/config/themes/light_theme.dart';
import 'package:chat/core/utils/screen.dart';
import 'package:chat/features/auth/presentation/pages/sign_in.dart';
import 'package:chat/features/auth/presentation/pages/sign_up.dart';
import 'package:chat/features/global/presentations/blocs/theme_cubit.dart';
import 'package:chat/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

/// Integration test must be done on the integration_test folder
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    initializeDependencies();
  });

  Widget createWidgetUnderTest() {
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

  testWidgets(
    "Navigates to sign up page",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      await tester.tap(find.text("Create new account"));
      await tester.pumpAndSettle();

      expect(find.byType(SignIn), findsNothing);
      expect(find.byType(SignUp), findsOneWidget);

      final emailTextFiled = find.byKey(const ValueKey("EmailHintText"));
      await tester.enterText(emailTextFiled, "abcdefgh@gmail.com");
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
    },
  );
}
