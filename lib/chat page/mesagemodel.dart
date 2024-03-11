class messageModel {
  String id;
  int fromId;
  int toId;
  String body;
  dynamic attachment;
  int seen;
  String createdAt;
  String updatedAt;

  messageModel({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.body,
    this.attachment,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });


  factory messageModel.fromMap(Map<String,dynamic> m)
  {
   String id = m["id"];
   int fromId = m["from_id"];
   int toId = m["to_id"];
   String message = m["body"];
   dynamic attachment = m["attachment"];
   int seen = m["seen"];
   String createdAt = m["created_at"];
   String updatedAt = m["updated_at"];

   return messageModel(id: id, fromId: fromId, toId: toId,attachment: attachment, body: message, seen: seen, createdAt: createdAt, updatedAt: updatedAt);
  }

  toMao()
  {
    return {
      "id": id,
      "from_id": fromId,
      "to_id":toId,
      "body": body,
      "attachment": attachment,
      "seen": seen,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }

}