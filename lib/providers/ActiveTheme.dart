// ignore_for_file: file_names
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeTheme = StateProvider((ref) =>  Themes.light);

enum Themes {
  dark,
  light
}
