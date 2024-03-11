// To parse this JSON data, do
//
//     final notificationdateModel = notificationdateModelFromJson(jsonString);

import 'dart:convert';



NotificationdateModel notificationdateModelFromJson(String str) => NotificationdateModel.fromJson(json.decode(str));

String notificationdateModelToJson(NotificationdateModel data) => json.encode(data.toJson());

class NotificationdateModel {
  dynamic message;
  bool? success;
  NotificationdateModelData? data;

  NotificationdateModel({
    this.message,
    this.success,
    this.data,
  });

  factory NotificationdateModel.fromJson(Map<String, dynamic> json) {

    dynamic _message = json["message"];
    bool _success = json["success"];
    NotificationdateModelData? _data  =   json["data"]==null ? null : NotificationdateModelData.fromJson(json["data"]);


     NotificationdateModel mdate = NotificationdateModel(
      message: _message,
      success: _success,
      data: _data,
    );

     return mdate;
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data?.toJson(),
  };
}

class NotificationdateModelData {
  List<NotificationElement>? notifications;
  int? unread;

  NotificationdateModelData({
    this.notifications,
    this.unread,
  });

  factory NotificationdateModelData.fromJson(Map<String, dynamic> json) {
    var model =NotificationdateModelData(
      notifications: json["notifications"] == null ? [] : List<NotificationElement>.from(json["notifications"]!.map((x) => NotificationElement.fromJson(x))),
      unread: json["unread"],
    );


    return model;
  }

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "unread": unread,
  };
}

class NotificationElement {
  int? id;
  int? userId;
  NotificationNotification? notification;
  DateTime? createdAt;
  DateTime? updatedAt;
  NotificationData? data;
  int? read;
  Type? type;

  NotificationElement({
    this.id,
    this.userId,
    this.notification,
    this.createdAt,
    this.updatedAt,
    this.data,
    this.read,
    this.type,
  });

  factory NotificationElement.fromJson(Map<String, dynamic> json) {

    print("_"*50+ "id  = ${json["id"]} start");

    var model =  NotificationElement(
      id: json["id"],
      userId: json["user_id"],
      notification: json["notification"] == null ? null : NotificationNotification.fromJson(json["notification"]),
      //bg
      createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      data: json["data"] == null ? null : NotificationData.fromJson(json["data"]),
      read: json["read"],
      type: typeValues.map[json["type"]]!,
    );
    print("_"*50+ "id  = ${json["id"]} end");

    return model;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "notification": notification?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "data": data?.toJson(),
    "read": read,
    "type": typeValues.reverse[type],
  };
}

class NotificationData {
  TypeId? typeId;
  Type? type;
  DateTime? dateTime;

  NotificationData({
    this.typeId,
    this.type,
    this.dateTime,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {




    // DateTime _dateTime =  json["date_time"] == null ? null : DateTime.parse(json["date_time"]);
    var model =  NotificationData(
      typeId: json["type_id"] == null ? null : TypeId.fromJson(json["type_id"]),
      type: typeValues.map[json["type"]]!,
      dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    );
    print("done");

    return model;
  }

  Map<String, dynamic> toJson() => {
    "type_id": typeId?.toJson(),
    "type": typeValues.reverse[type],
    "date_time": dateTime?.toIso8601String(),
  };
}

enum Type {
  CHAT_MESSAGE,
  FOLLOW_REQUEST,
  POST_REACTION,
  POST_ADDED,
  MESSAGE_ONLY,
}

final typeValues = EnumValues({
  "chatMessage": Type.CHAT_MESSAGE,
  "followRequest": Type.FOLLOW_REQUEST,
  "postReaction": Type.POST_REACTION,
  "messageOnly":Type.MESSAGE_ONLY,
  "postAdded":Type.POST_ADDED,
});

class TypeId {
  int? userId;
  String? communityId;
  int? postId;
  int? invitationId;

  TypeId({
    this.userId,
    this.communityId,
    this.postId,
    this.invitationId,
  });

  factory TypeId.fromJson(Map<String, dynamic> json) {
    print("type_id Start");


    int? _userId = json["user_id"];
    print(1);

    print(json["community_id"].runtimeType);
    String? _communityId = json["community_id"].toString();
    print(1);

    int? _postId = json["post_id"];



   var model =  TypeId(
      userId: json["user_id"],
      communityId: _communityId,
      postId: json["post_id"],
     invitationId: json["invitation_id"]
    );
    print("type_id end");
   return model;
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "community_id": communityId,
    "post_id": postId,
  };
}

class NotificationNotification {
  String? title;
  String? body;
  String? image;

  NotificationNotification({
    this.title,
    this.body,
    this.image,
  });

  factory NotificationNotification.fromJson(Map<String, dynamic> json){
    print("Genrating messaeg id = ${json["title"]}");
    var model = NotificationNotification(
      title: json["title"],
      body: json["body"],
      image: json["image"],
    );

    print("done = ${json["title"]}");
    return model;
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "image": image,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
