class UserM {
   String? id;
  String? displayName;
   String? email;
   String? role;
  
  UserM({this.id, this.displayName, this.role, this.email});

  UserM.fromJson(String id, Map<String, dynamic> json) : this(
    id: id,
    displayName: json["display_name"],
     email: json['email'],
    role: json["role"]
   
  );

  Map<String, Object?> toJson(){
    return {
      "display_name" : displayName,
      "email" : email,
      "role" : role
    };
  }
}