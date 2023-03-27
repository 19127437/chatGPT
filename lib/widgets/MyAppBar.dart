import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:chatgpt/widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Chat GPT',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      actions: [
        Row(children: [
          Consumer(
              builder: (context, ref , child) => Icon(ref.watch(activeTheme) == Themes.dark ? Icons.dark_mode : Icons.light_mode)
          ),
          SizedBox(width: 8,),
          ThemeSwitch(),
        ],)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

