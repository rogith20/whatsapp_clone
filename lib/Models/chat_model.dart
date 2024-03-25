class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentmsg;
  String about;
  bool select = false;

  ChatModel({
    this.name = '',
    this.icon = '',
    this.isGroup = false,
    this.time = '',
    this.currentmsg = '',
    this.about = '',
    this.select = false,
  });

  int? get id => null;
}
