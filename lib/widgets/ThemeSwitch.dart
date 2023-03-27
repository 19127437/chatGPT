import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitch extends ConsumerStatefulWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  ConsumerState<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends ConsumerState<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return  Switch.adaptive(
        activeColor: Theme.of(context).colorScheme.secondary,
        value: ref.watch(activeTheme) == Themes.dark,
        onChanged: (value) {
        ref.read(activeTheme.notifier).state = value ? Themes.dark : Themes.light;
      }
    );
  }
}
