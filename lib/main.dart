import 'package:chatgpt/constants/themes.dart';
import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:chatgpt/view/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeThemeProvider = ref.watch(activeTheme);
    return MaterialApp(
      theme: lightTheme,
      darkTheme:darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: activeThemeProvider == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: const ChatScreen(),
    );
  }
}

