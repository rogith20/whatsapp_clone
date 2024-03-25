import 'package:flutter/material.dart';
import 'package:my_whatsapp/Models/chat_model.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.contact});
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Stack(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Color(0xFFD2D7DB),
                child: FractionalTranslation(
                  translation: Offset(-0.1, 0), // Adjust the values as needed
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 55,
                  ),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: -0.2,
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 7,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 10,
                      )))
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            contact.name,
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
