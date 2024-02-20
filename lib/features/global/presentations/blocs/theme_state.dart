part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  ThemeState get toggle => themeMode == ThemeMode.light ? ThemeState.dark() : ThemeState.light();
  factory ThemeState.light() => const ThemeState(ThemeMode.light);
  factory ThemeState.dark() => const ThemeState(ThemeMode.dark);
  factory ThemeState.system() =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.light
          ? ThemeState.light()
          : ThemeState.dark();

  @override
  List<Object?> get props => [themeMode];
}
