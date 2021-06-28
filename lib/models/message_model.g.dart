// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    sender: json["sender"] as String,
    receiver: json["receiver"] as String,
    time: (json["time"] as Timestamp).toDate().toString(),
    text: json['text'] as String,
    isLiked: json['isLiked'] as bool,
    unread: json['unread'] as bool,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'sender': instance.sender,
      'time': instance.time,
      'text': instance.text,
      'isLiked': instance.isLiked,
      'unread': instance.unread,
    };
