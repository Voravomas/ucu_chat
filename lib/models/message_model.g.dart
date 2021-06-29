// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  final senderName = json["senderName"];
  print(json['content'] == null);
  print(json["time"] == null ? "time null" : 'not null');
  final time =
      ((json["time"] == null ? Timestamp(0, 0) : json["time"]) as Timestamp)
          .toDate();
  return Message(
    senderName:
        (json["senderName"] != null ? json["senderName"] : "") as String,
    // receiver: json["receiver"] as String,
    time: (time.hour == 0 ? "00" : time.hour.toString()) +
        ":" +
        (time.minute == 0 ? "00" : time.minute.toString()),
    content: (json['content'] != null ? json['content'] : " ") as String,
    // isLiked: json['isLiked'] as bool,
    // unread: json['unread'] as bool,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderName': instance.senderName,
      'time': instance.time,
      'content': instance.content
      // 'isLiked': instance.isLiked,
      // 'unread': instance.unread,
    };
