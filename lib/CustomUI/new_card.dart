import 'package:flutter/material.dart';

class NewCard extends StatelessWidget {
  const NewCard({Key? key, this.name = '', this.icon}) : super(key: key);
  final String name;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 19,
        backgroundColor: const Color(0xFF00A884),
        child: Icon(
          icon,
          color: Colors.white,
          size: 23,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
