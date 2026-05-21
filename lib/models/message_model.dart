import 'package:chat_app/constant.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);

  // ignore: strict_top_level_inference
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData[kCollectionMessage], jsonData['id']);
  }
}
