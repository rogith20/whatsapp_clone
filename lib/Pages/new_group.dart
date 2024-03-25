import 'package:flutter/material.dart';
import 'package:my_whatsapp/CustomUI/avatar_card.dart';
import 'package:my_whatsapp/CustomUI/contact_card.dart';
import 'package:my_whatsapp/CustomUI/new_card.dart';
import 'package:my_whatsapp/Models/chat_model.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key});

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Rogith",
      about: "Hey there! I\'m using WhatsApp",
    ),
    ChatModel(
      name: "Amma",
      about: "Sleeping",
    ),
    ChatModel(
      name: "Soniya",
      about: "Busy",
    ),
    ChatModel(
      name: "Thulasi",
      about: "At the gym",
    ),
  ];
  List<ChatModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Group',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                'Add participants',
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 26,
                )),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length+ 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(height: groups.length > 0 ? 90 : 10,);
                  }
                  return InkWell(
                      onTap: () {
                        setState(() {
                          if (contacts[index - 1].select == true) {
                            groups.remove(contacts[index-1]);
                            contacts[index- 1].select = false;
                          } else {
                            groups.add(contacts[index-1]);
                            contacts[index- 1].select = true;
                          }
                        });
                      },
                      child: ContactCard(
                          contact: contacts[index- 1]
                      )
                  );
                }),
           groups.length>0 ? Column(
              children: [
                Container(
                  height: 75,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: contacts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if(contacts[index].select==true) {
                          return InkWell(onTap: () {
                            setState(() {
                              contacts[index].select = false;
                              groups.remove(contacts[index]);
                            });
                          }, child: AvatarCard(contact: contacts[index]));
                        }
                        else {
                          return Container();
                        }
                      }),
                ),
                Divider(
                  thickness: 1,
                )
              ],
            ) : Container()
          ],
        ));
  }
}
