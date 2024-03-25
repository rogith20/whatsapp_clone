import 'package:flutter/material.dart';
import 'package:my_whatsapp/CustomUI/camera_screen.dart';
import 'package:my_whatsapp/Pages/chats.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WhatsApp',
          //style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => CameraScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search icon pressed
            },
          ),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text('New group'),
                value: 'New Group',
              ),
              const PopupMenuItem(
                child: Text('New broadcast'),
                value: 'New Broadcast',
              ),
              const PopupMenuItem(
                child: Text('Linked Devices'),
                value: 'Linked Devices',
              ),
              const PopupMenuItem(
                child: Text('Starred messages'),
                value: 'Starred messages',
              ),
              const PopupMenuItem(
                child: Text('Settings'),
                value: 'Settings',
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.groups,
                //color: _selectedIndex == 0 ? Colors.white : Colors.white54,
              ),
            ),
            Tab(
              text: 'Chats',
            ),
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Calls',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          Text('community'),
          ChatPage(),
          Text('status'),
          Text('calls'),
        ],
      ),
    );
  }
}
