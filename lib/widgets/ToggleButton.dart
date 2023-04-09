import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatgpt/widgets/TextAndVoiceField.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback _sendText;
  final VoidCallback _sendVoice;
  final InputMode _inputMode;
  final bool _listening;
  final bool _reply;
  const ToggleButton({super.key, required InputMode inputMode, required bool listening,required bool reply, required VoidCallback sendText, required VoidCallback senVoice}) :
        _inputMode = inputMode, _listening = listening, _reply = reply,  _sendText = sendText, _sendVoice = senVoice;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget._reply
            ? null : widget._inputMode == InputMode.text ?
          widget._sendText : widget._sendVoice,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15)
        ),
        child:  AvatarGlow(
          animate: widget._listening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 18.0,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: const Duration(milliseconds: 20),
          child:  Icon(widget._inputMode == InputMode.text ? Icons.send
              : widget._listening ?
                Icons.mic: Icons.mic_off,
          )
        ),
    );
  }
}
