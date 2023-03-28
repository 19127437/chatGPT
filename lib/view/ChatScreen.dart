import 'package:chatgpt/providers/ChatProvider.dart';
import 'package:chatgpt/widgets/ChatItem.dart';
import 'package:chatgpt/widgets/MyAppBar.dart';
import 'package:chatgpt/widgets/TextAndVoiceField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref , child) {
                final chats = ref.watch(chatsProvider);
                return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) => ChatItem(text: chats[index].message, isMe: chats[index].isMe)
                );
              },
            ),
          ),
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

