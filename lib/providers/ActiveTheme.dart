import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeTheme = StateProvider((ref) => Themes.dark);

enum Themes {
  dark,
  light
}
