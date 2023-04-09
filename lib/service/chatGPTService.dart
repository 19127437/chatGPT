// ignore_for_file: deprecated_member_use

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgpt/providers/ChatProvider.dart';
class AIHandler {
  final _openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)));
  List<Map<String, String>> history = [];

  Future<String> getResponse(String message) async {
    try {
      history = [];
      if(listChatModel.length > 22){
        for ( int i=0;i<listChatModel.sublist(listChatModel.length -20).length ; i++){
          history.add({
            "role": listChatModel.sublist(listChatModel.length -20)[i].isMe ==true ? "user": "assistant",
            "content":listChatModel.sublist(listChatModel.length -20)[i].message
          });
        }
      }else{
        for ( int i=0;i<listChatModel.length ; i++){
          history.add({
            "role": listChatModel[i].isMe ==true ? "user": "assistant",
            "content":listChatModel[i].message
          });
        }
      }
      history.add({
        "role": "user",
        "content": message
      });
      final request = ChatCompleteText(messages:history , maxToken: 3500, model: ChatModel.ChatGptTurbo0301Model);

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        history.add({
          "role": "assistant",
          "content": response.choices[0].message.content.trim()
        });
        return response.choices[0].message.content.trim();
      }
      return 'Some thing went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }

  void dispose() {
    _openAI.close();
  }
}
