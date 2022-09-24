class Messages {
  List<MessageModel> messages = [];
  Messages.fromJson(Map<String, dynamic> json) {
    json['offers'].forEach((element) {
      messages.add(MessageModel.fromJson(element));
    });
  }
}

class MessageModel {
  int? id;
  String? text;
  int? user_id;
  int? offer_id;
  String? name;

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    user_id = json['user_id'];
    offer_id = json['offer_id'];
    name = json['name'];
  }
}
