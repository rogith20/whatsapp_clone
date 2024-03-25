import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_whatsapp/Models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          titleSpacing: 5,
          leadingWidth: 70,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFFD2D7DB),
                  child: SvgPicture.asset(
                    widget.chatModel.isGroup
                        ? 'assets/group.svg'
                        : 'assets/person.svg',
                    color: Colors.white,
                    height: 22,
                    width: 22,
                  ),
                )
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatModel.name,
                  style: const TextStyle(
                      fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'last seen today at 4:00 pm',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                )
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            PopupMenuButton<String>(onSelected: (value) {
              print(value);
            }, itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text('View Contact'),
                  value: 'View Contact',
                ),
                const PopupMenuItem(
                  child: Text('Media, links, and docs'),
                  value: 'Media, links, and docs',
                ),
                const PopupMenuItem(
                  child: Text('Linked Devices'),
                  value: 'Linked Devices',
                ),
                const PopupMenuItem(
                  child: Text('Search'),
                  value: 'Search',
                ),
                const PopupMenuItem(
                  child: Text('Mute Notifications'),
                  value: 'Mute Notifications',
                ),
                const PopupMenuItem(
                  child: Text('Diappearing messages'),
                  value: 'Diappearing messages',
                ),
                const PopupMenuItem(
                  child: Text('Wallpaper'),
                  value: 'Wallpaper',
                ),
                const PopupMenuItem(
                  child: Text('More'),
                  value: 'More',
                ),
              ];
            })
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              ListView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: _controller,
                                focusNode: focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                minLines: 1,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            show = !show;
                                          });
                                        },
                                        icon: Icon(
                                            show
                                                ? Icons.keyboard
                                                : Icons.emoji_emotions_outlined,
                                            color: const Color(0xFF8596a0))),
                                    hintText: "Message",
                                    contentPadding: const EdgeInsets.all(5),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                            icon: const Icon(
                                              Icons.attach_file,
                                              color: Color(0xFF8596a0),
                                            )),
                                        const IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.currency_rupee,
                                              color: Color(0xFF8596a0),
                                            )),
                                        const IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.camera_alt,
                                              color: Color(0xFF8596a0),
                                            )),
                                      ],
                                    )),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 5, bottom: 8),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFF075E54),
                            radius: 25,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.mic,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                    show ? emojiSelect() : Container(),
                  ],
                ),
              ),
            ],
          ),
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return Container(
      height: 320,
      child: EmojiPicker(
        config: const Config(
            //columns: 7,
            ),
        onEmojiSelected: (category, emoji) {
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        },
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 395,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardicon(Icons.insert_drive_file, Colors.indigo, "Document"),
                  const SizedBox(width: 40),
                  cardicon(Icons.camera_alt, Colors.pink, "Camera"),
                  const SizedBox(width: 40),
                  cardicon(Icons.photo, Colors.deepPurple, "Gallery"),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardicon(Icons.headphones, Colors.deepOrange, "Audio"),
                  const SizedBox(width: 40),
                  cardicon(
                      Icons.location_on, const Color(0xFF1FA755), "Location"),
                  const SizedBox(width: 40),
                  cardicon(
                      Icons.currency_rupee, const Color(0xFF03A598), "Payment"),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardicon(Icons.person, Colors.blue, "Contact"),
                  const SizedBox(width: 40),
                  cardicon(Icons.bar_chart, Colors.teal, "Poll"),
                  const SizedBox(width: 100),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardicon(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
