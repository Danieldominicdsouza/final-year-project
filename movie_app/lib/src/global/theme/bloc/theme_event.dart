part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  final AppTheme theme;

  const ThemeEvent({this.theme});

  @override
  List<Object> get props => [theme];
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({this.theme}) : super(theme: theme);
}
