import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:chatgpt/view/Setting.dart';
import 'package:chatgpt/widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
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
          IconButton(
            icon: Icon( Icons.settings,   color: Theme.of(context).colorScheme.onPrimary,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
          ),
          SizedBox(width: 4,),
        ],)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

