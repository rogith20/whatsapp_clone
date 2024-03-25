import 'package:flutter/material.dart';
import 'package:my_whatsapp/CustomUI/custom_card.dart';
import 'package:my_whatsapp/Models/chat_model.dart';
import 'package:my_whatsapp/Pages/select_contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: "Flutter Group",
      isGroup: true,
      currentmsg: "Anyone free tmrw?",
      time: "4:00",
      icon: "group.svg",
    ),
    ChatModel(
      name: "Soniya",
      isGroup: false,
      currentmsg: "Hi",
      time: "4:23",
      icon: "person.svg",
    ),
    ChatModel(
      name: "Rogith",
      isGroup: false,
      currentmsg: "UNO reverse",
      time: "5:00",
      icon: "person.svg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF075E54),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
        itemCount: chats.length,
      ),
    );
  }
}
