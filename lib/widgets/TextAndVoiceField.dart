import 'package:chatgpt/models/chatModel.dart';
import 'package:chatgpt/providers/ChatProvider.dart';
import 'package:chatgpt/service/chatGPTService.dart';
import 'package:chatgpt/service/voiceChatGPT.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ToggleButton.dart';
enum InputMode{
  text,
  voice
}


class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  var reply = false;
  var _listening = false;

  final _messageController = TextEditingController();
  final AIHandler _openAi = AIHandler();
  final VoiceHandler voiceHandler = VoiceHandler();

  @override
  void initState(){
    voiceHandler.initSpeech();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        reply == false ? const Text('')  : const Text('Waiting for reply...', style: TextStyle(fontSize: 16, color: Colors.grey),),
        const SizedBox(height: 5,),
        Row(
          children: [
            // _inputMode == InputMode.voice ? ToggleButton(inputMode: _inputMode,): SizedBox(),
            Expanded(child: TextField(
              controller: _messageController,
              onChanged: (value){
                value.isEmpty || value.length == 0 ? setInputMode(InputMode.voice) : setInputMode(InputMode.text);
              },
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
            )),
            const SizedBox(
              width: 06,
            ),
            ToggleButton(
              inputMode: _inputMode,
              reply: reply,
              listening: _listening,
              sendText: (){
                final mess = _messageController.text;
                _messageController.clear();
                sendTextMessage(mess);
              },
              senVoice: sendVoiceMessage,
            )
          ],
        )
      ],
    );
  }
  void setInputMode(InputMode inputMode){
    setState(() {
      _inputMode = inputMode;
    });
  }
  void setListeningState(bool check) {
    setState(() {
      _listening = check;
    });
  }
  Future<void> sendTextMessage(String message) async {
    setState(() {
      reply= true;
    });
    addToList(message, true);
    final aiResponse = await _openAi.getResponse(message);
    addToList(aiResponse, false);
    setState(() {
      reply= false;
    });
    setListeningState(false);

    setInputMode(InputMode.voice);
  }
  void addToList(String message, bool isMe) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      message: message,
      isMe: isMe,
    ));
  }
  void sendVoiceMessage() async {
    if(voiceHandler.speechToText.isListening){
      await voiceHandler.stopListening();
      setListeningState(false);
    }else{
      setListeningState(true);
      final result = await voiceHandler.startListening();
      setListeningState(false);
      sendTextMessage(result);
    }
  }
}
