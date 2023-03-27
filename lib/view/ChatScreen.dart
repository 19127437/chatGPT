import 'package:chatgpt/widgets/MyAppBar.dart';
import 'package:chatgpt/widgets/TextAndVoiceField.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) => const Text(
              'List'
            ),
          )),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: TextAndVoiceField()
          ),
          const SizedBox(
            height: 10,
          )
        ],
      )
    );
  }
}

