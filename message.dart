import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String? id;
String? fromId;
String? toId;
String? content;
Timestamp? created;

MessageModel({
this.id,this.fromId,this.toId,this.content,this.created


});

MessageModel.fromJson(String id, Map<String,dynamic> json)
: this(id: id, fromId: json["fromId"], toId: json['toId'],content: json["content"],created: json["created"]);

Map<String,dynamic> toJson(){
  return {"fromId": fromId, "toId": toId, "created": created, "content": content};

}
}

