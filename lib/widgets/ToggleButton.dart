import 'package:chatgpt/widgets/TextAndVoiceField.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback _sendText;
  final VoidCallback _sendVoice;
  final InputMode _inputMode;
  const ToggleButton({super.key, required InputMode inputMode, required VoidCallback sendText, required VoidCallback senVoice}) :
        _inputMode = inputMode, _sendText = sendText, _sendVoice = senVoice;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget._inputMode == InputMode.text ?
          widget._sendText : widget._sendVoice,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15)
        ),
        child: Icon(widget._inputMode == InputMode.text ? Icons.send : Icons.mic)
    );
  }
}
