import 'package:flutter/material.dart';

import 'ToggleButton.dart';
enum InputMode{
  text,
  voice
}


class TextAndVoiceField extends StatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  State<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends State<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextField(
          onChanged: (value){
            value.isNotEmpty ? setInputMode(InputMode.text) : setInputMode(InputMode.voice);
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
        ToggleButton(inputMode: _inputMode,)
      ],
    );
  }
  void setInputMode(InputMode inputMode){
    setState(() {
      _inputMode = inputMode;
    });
  }
}
