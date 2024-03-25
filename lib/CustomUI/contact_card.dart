import 'package:flutter/material.dart';
import 'package:my_whatsapp/Models/chat_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 43,
        width: 43,
        child: Stack(
          children: [
            const CircleAvatar(
              radius: 19,
              backgroundColor: Color(0xFFD2D7DB),
              child: FractionalTranslation(
                translation: Offset(-0.1, 0), // Adjust the values as needed
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
            contact.select
                ? const Positioned(
                    bottom: 1,
                    right: -0.2,
                    child: CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 10,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        )))
                : Container(),
          ],
        ),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        contact.about,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
