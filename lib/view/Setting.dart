import 'dart:convert';

import 'package:chatgpt/providers/ChatProvider.dart';
import 'package:chatgpt/widgets/ChatItem.dart';
import 'package:chatgpt/widgets/MyAppBar.dart';
import 'package:chatgpt/widgets/TextAndVoiceField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatgpt/widgets/ThemeSwitch.dart';
import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatgpt/providers/TextToSpeech.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
const textToSpeech = [
  '{"name": "English","id":"en-US"}','{"name": "Vietnamese","id":"vi-VN"}'
];

class _SettingState extends State<Setting> {

  bool _isExpanded = false;
  bool _isEnabled = false;
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Setting',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(20)
                ),
                child:Row(
                  children: [
                    Text(
                      'Light Screen',
                      style: TextStyle(
                        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500
                      ),
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Consumer(
                                builder: (context, ref , child) => Icon(ref.watch(activeTheme) == Themes.dark ? Icons.dark_mode : Icons.light_mode)
                            ),
                            SizedBox(width: 8,),
                            ThemeSwitch(),
                          ],
                        )
                    ),
                  ],
                )
              ),
              SizedBox(height: 10,),
              Container(
                  padding: const EdgeInsets.all(15),
                  constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child:Column(
                    children: [
                      const Text(
                        'AI Voice',
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    setLanguage.toString() == "en-US"  ? "assets/icons/england.svg"
                                        : "assets/icons/vietnam.svg",
                                    width: 35,
                                    height: 35,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    setLanguage.toString() == "en-US" ?  'English' : 'Vietnamese',
                                    style: const TextStyle(
                                      color: Colors.black, fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isExpanded = !_isExpanded;
                                      });
                                    },
                                    child: Icon( Icons.arrow_forward_ios, color:Colors.grey.shade800,)
                                ),
                              ],
                            )
                          ),

                          // SizedBox(width: MediaQuery.of(context).size.width * 0.6 ,),

                        ],
                      ),
                      SizedBox(height: 10,),
                      if (_isExpanded)
                        Wrap(
                            spacing: 6,
                            runSpacing: 8,
                            children: List<Widget>.generate(
                              textToSpeech.length,
                                  (index) =>Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      InkWell(
                                          onTap: () {
                                            setLanguage = jsonDecode(textToSpeech[index].toString())["id"];
                                            setState(() {
                                              _isExpanded = !_isExpanded;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                jsonDecode(textToSpeech[index].toString())["name"] == "English" ? "assets/icons/england.svg"
                                                : "assets/icons/vietnam.svg",
                                                width: 35,
                                                height: 35,
                                              ),
                                              SizedBox(width: 10,),
                                              Text( jsonDecode(textToSpeech[index].toString())["name"] ,  style: TextStyle(fontSize: 16,
                                              ),),
                                            ],
                                          )
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 1,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                            )
                        ),
                    ],
                  ),
              ),
              SizedBox(height: 10,),
              Container(
                  padding: const EdgeInsets.all(15),
                  constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child:Row(
                    children: [
                      const Text(
                        'Auto TTS replice',
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500
                        ),
                      ),
                      Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:  [
                              Switch.adaptive(
                                value: autoSpeech,
                                onChanged: (value) {
                                  setState(() {
                                    autoSpeech = !autoSpeech;
                                    print(autoSpeech);
                                  });
                                },
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}

