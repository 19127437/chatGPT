import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../providers/TextToSpeech.dart';

class ChatItem extends StatefulWidget {
  final String text;
  final bool isMe;
  const ChatItem({super.key, required this.text, required this.isMe});

  @override
  State<ChatItem> createState() => _ChatItemState();
}
enum TtsState { playing, stopped, paused, continued }

class _ChatItemState extends State<ChatItem> {
  bool speech = false;
  bool _isListening = false;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 0.5;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setSpeechRate(pitch);
    flutterTts.setVolume(volume);
    if(!widget.isMe && autoSpeech) {
      _speak(widget.text);
    }
  }
  Future<void> _speak(String text) async {
    await flutterTts.setLanguage(setLanguage);
    setState(() {
      speech = !speech;
    });
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true);
    setState(() {
      speech = !speech;
    });
  }
  void setInputMode(){
    setState(() {
      speech = !speech;
    });
  }


  Future<void> _stop() async {
    setState(() {
      speech = !speech;
    });
    setState(() {
      speech = !speech;
    });
    await flutterTts.stop();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!widget.isMe) IconChat(isMe: widget.isMe),
          if(!widget.isMe) SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.all(15),
            constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width * 0.6),
            decoration: BoxDecoration(
              color: widget.isMe? Colors.lightBlue : Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft:  Radius.circular(widget.isMe ? 15 :0),
                bottomRight:  Radius.circular(widget.isMe? 0: 15),
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          if(!widget.isMe) SizedBox(width: 5),
          if(!widget.isMe) ElevatedButton(
              onPressed: () {
                !speech ? _speak(widget.text): _stop();
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(width: 2, color: Colors.grey.shade800),
                ),
                padding: EdgeInsets.all(10.0),
              ),
              child: speech? Icon( Icons.pause_circle, color: Colors.grey.shade800,) :Icon( Icons.play_circle, color:Colors.grey.shade800,)
          ),
          if(widget.isMe) SizedBox(width: 5),
          if(widget.isMe) IconChat(isMe: widget.isMe),
        ],
      ),
    );
  }
}

class IconChat extends StatelessWidget {
  const IconChat({
    super.key,
    required this.isMe,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isMe? Colors.lightBlue : Colors.grey.shade800,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft:  Radius.circular(isMe ? 0 :15),
          bottomRight:  Radius.circular(isMe? 15: 0),
        )
      ),
      // child: Icon(isMe? Icons.person: Icons.computer, color: Theme.of(context).colorScheme.onSecondary,),
      child: isMe?  Icon( Icons.person, color: Theme.of(context).colorScheme.onSecondary,)  :
      // Icon( Icons.computer, color: Theme.of(context).colorScheme.onSecondary,)
      SvgPicture.asset(
        "assets/icons/chatgpt.svg",
        width: 35,
        height: 35,
      ),

      // SvgPicture.asset(
      //   'assets/images/chatgpt-icon.svg',
      //   width: 24,
      //   height: 24,
      // )
    );
  }
}
