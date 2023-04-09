
import 'package:chatgpt/models/chatModel.dart';
import 'package:chatgpt/providers/ChatProvider.dart';
import 'package:chatgpt/widgets/ChatItem.dart';
import 'package:chatgpt/widgets/MyAppBar.dart';
import 'package:chatgpt/widgets/TextAndVoiceField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late Future<String> listLocal;
  List<ChatModel> chatModels = listChatModel;


  @override
  void initState() {
    super.initState();
    getChatModel();
    chatsProvider;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref , child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
                final chats = ref.watch(chatsProvider);
                getChatModel();
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: listChatModel.length,
                    itemBuilder: (context, index) => ChatItem(text: listChatModel[index].message, isMe: listChatModel[index].isMe)
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

