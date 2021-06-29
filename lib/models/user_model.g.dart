// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  print(json["imageUrl"] == null);
  return User(
      id: json['id'] as String, //
      name: json['name'] as String, //
      imageUrl: json['imgUrl'] as String, //
      occupation: json['occupation'] as String, //
      email: json['email'] as String, //
      phone: json['phone'] as String, //
      chatids: json["chatsList"] as List<String>,
      personalChatIds: json["personalChats"] as List<Map<String, dynamic>>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'occupation': instance.occupation,
      'email': instance.email,
      'phone': instance.phone,
    };
