import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_whatsapp/Models/chat_model.dart';
import 'package:my_whatsapp/Pages/chat_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: chatModel,
                      sourchat: chatModel,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 26,
              child: SvgPicture.asset(
                chatModel.isGroup ? 'assets/group.svg' : 'assets/person.svg',
                color: Colors.white,
                height: 32,
                width: 32,
              ),
              backgroundColor: const Color(0xFFD2D7DB),
            ),
            title: Text(
              chatModel.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.done_all,
                  size: 18,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentmsg,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            trailing: Text(
              chatModel.time,
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
