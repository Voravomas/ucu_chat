// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  print(json["imageUrl"] == null);
  return User(
    id: json['id'] as String, //
    name: (json['name'] as String).replaceAll("\'", "").replaceAll('\"', ""), //
    imageUrl: json['imgUrl'] as String, //
    occupation: json['occupation'] as String, //
    email: json['email'] as String, //
    phone: json['phone'] as String,
    chatsList: new List<String>.from(json['chatsList']),
    personalChats: json['personalChats'] as List<dynamic>, //
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'occupation': instance.occupation,
      'email': instance.email,
      'phone': instance.phone,
    };
