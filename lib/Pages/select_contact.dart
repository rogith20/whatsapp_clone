import 'package:flutter/material.dart';
import 'package:my_whatsapp/CustomUI/contact_card.dart';
import 'package:my_whatsapp/CustomUI/new_card.dart';
import 'package:my_whatsapp/Models/chat_model.dart';
import 'package:my_whatsapp/Pages/new_group.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts =[
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

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Select Contact',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
          Text('338 contacts',style: TextStyle(fontSize: 13),)],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search,size: 26,)),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text('Invite a friend           '),
                value: 'Invite a friend',
              ),
              const PopupMenuItem(
                child: Text('Contacts'),
                value: 'Contacts',
              ),
              const PopupMenuItem(
                child: Text('Refresh'),
                value: 'Refresh',
              ),
              const PopupMenuItem(
                child: Text('Help'),
                value: 'Help',
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(itemCount: contacts.length +3,
          itemBuilder: (context,index)
          { if(index==0)
          {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>NewGroup()));
              },
                child: NewCard(icon: Icons.group,name: 'New group',));
          }
          else if(index==1) {
            return NewCard(icon: Icons.person_add,name: 'New contact',);
          }
          else if(index==2) {
            return NewCard(icon: Icons.groups,name: 'New community',);
          }
          return ContactCard(contact: contacts[index-3]);
          }
      )
    );
  }
}
