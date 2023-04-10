import 'dart:convert';

import 'package:chatgpt/view/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatgpt/widgets/ThemeSwitch.dart';
import 'package:chatgpt/providers/ActiveTheme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chatgpt/providers/TextToSpeech.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/ChatProvider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
const textToSpeech = [
  '{"name": "English","id":"en-US"}','{"name": "Vietnam","id":"vi-VN"}'
];

const speechToText = [
  '{"name": "English","id":"en-US"}','{"name": "Vietnam","id":"vi-VN"}','{"name": "Germany","id":"de-DE"}','{"name": "Russia","id":"ru-RU"}','{"name": "Croatia","id":"hr-HR"}'
];

class _SettingState extends State<Setting> {

  bool _isExpanded = false;
  bool _isExpandedSpeech = false;

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
          child: ListView(
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
                      const Text(
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
                              const SizedBox(width: 8,),
                              const ThemeSwitch(),
                            ],
                          )
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 10,),
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
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  setLanguage.toString() == "en-US"  ? "assets/icons/england.svg"
                                      : "assets/icons/Vietnam.svg",
                                  width: 35,
                                  height: 35,
                                ),
                                const SizedBox(width: 5,),
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
                    const SizedBox(height: 10,),
                    if (_isExpanded)
                      Wrap(
                          spacing: 6,
                          runSpacing: 8,
                          children: List<Widget>.generate(
                            textToSpeech.length,
                                (index) =>Column(
                              children: [
                                const SizedBox(height: 10,),
                                InkWell(
                                    onTap: (  ) async {
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('setLanguage', jsonDecode(textToSpeech[index].toString())["id"]);
                                      setLanguage = prefs.getString('setLanguage')?? "en-US";
                                      setState(() {
                                        _isExpanded = !_isExpanded;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          jsonDecode(textToSpeech[index].toString())["name"] == "English" ? "assets/icons/england.svg"
                                              : "assets/icons/Vietnam.svg",
                                          width: 35,
                                          height: 35,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text( jsonDecode(textToSpeech[index].toString())["name"] ,  style: const TextStyle(fontSize: 16,
                                        ),),
                                      ],
                                    )
                                ),
                                const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
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
                                  });
                                },
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 10,),
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
                      'Speech Language',
                      style: TextStyle(
                        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  setLanguageSpeech.toString() == "en-US"  ? "assets/icons/england.svg"
                                  : setLanguageSpeech.toString() == "vi-VN"?"assets/icons/Vietnam.svg"
                                      : setLanguageSpeech.toString() == "de-DE"?"assets/icons/Germany.svg"
                                      : setLanguageSpeech.toString() == "ru-RU"?"assets/icons/Russia.svg"
                                      : "assets/icons/Croatia.svg",
                                  width: 35,
                                  height: 35,
                                ),
                                const SizedBox(width: 5,),
                                Text(
                                  setLanguageSpeech.toString() == "en-US"  ?  'English'
                                      : setLanguageSpeech.toString() == "vi-VN"?'Vietnamese'
                                      : setLanguageSpeech.toString() == "de-DE"?'German'
                                      : setLanguageSpeech.toString() == "ru-RU"?'Russian'
                                      : 'Croatian',
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
                                        _isExpandedSpeech = !_isExpandedSpeech;
                                      });
                                    },
                                    child: Icon( Icons.arrow_forward_ios, color:Colors.grey.shade800,)
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    if (_isExpandedSpeech)
                      Wrap(
                          spacing: 6,
                          runSpacing: 8,
                          children: List<Widget>.generate(
                            speechToText.length,
                                (index) =>Column(
                              children: [
                                const SizedBox(height: 10,),
                                InkWell(
                                    onTap: (  ) async {
                                      setLanguageSpeech =  jsonDecode(speechToText[index].toString())["id"];
                                      setState(() {
                                        _isExpandedSpeech = !_isExpandedSpeech;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          jsonDecode(speechToText[index].toString())["name"] == "English" ? "assets/icons/england.svg"
                                              : "${"assets/icons/" + jsonDecode(speechToText[index].toString())["name"]}.svg",
                                          width: 35,
                                          height: 35,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text( jsonDecode(speechToText[index].toString())["name"] ,  style: const TextStyle(fontSize: 16,
                                        ),),
                                      ],
                                    )
                                ),
                                const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
              Consumer(
                builder: (context, ref , child ){
                  return InkWell(
                    onTap: () async {
                      deleteChatModel();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                        decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  const [
                            Text(
                              'DELETE CHAT',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        )
                    ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}

