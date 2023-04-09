import 'package:chatgpt/view/Setting.dart';
import 'package:flutter/material.dart';

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
                MaterialPageRoute(builder: (context) => const Setting()),
              );
            },
          ),
          const SizedBox(width: 4,),
        ],)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

