import 'package:flutter/material.dart';

class ChatModel{
  final String message;
  final bool isMe;

  const ChatModel({ required this.message, required this.isMe});
  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    message: json['message'],
    isMe: json['isMe']
  );
  Map<String, dynamic> toJson() => {
    'message': message,
    'isMe': isMe
  };
}
