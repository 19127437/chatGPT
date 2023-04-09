import 'dart:async';
import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import '../providers/ChatProvider.dart';

class VoiceHandler {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    // _speechToText.listen(
    //   localeId: 'vi-VN',
    // );
  }
  // void _startListening() async {
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   setState(() {});
  // }
  //
  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }
  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     _lastWords = result.recognizedWords;
  //   });
  // }


  Future<String> startListening() async {
    final completer = Completer<String>();
    _speechToText.listen(
      onResult: (SpeechRecognitionResult result) {
        if (result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
      // listenFor: Duration(seconds: 30),
      localeId: setLanguageSpeech,
      listenMode: ListenMode.confirmation,
    );
    return completer.future;
  }


  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnabled;
}