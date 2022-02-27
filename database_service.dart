/*import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/user.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Map<String, UserM> userMap = <String, UserM>{};
  final StreamController<Map<String, UserM>> _usersController =
      StreamController<Map<String, UserM>>();
   final StreamController<Post> _postController =
      StreamController<Post>();
  final StreamController<List<UserM>> _userListController =
      StreamController<List<UserM>>();
  
  Stream<Map<String, UserM>> get users => _usersController.stream;
  Stream<Post> get post => _postController.stream;
  Stream<List<UserM>> get userList => _userListController.stream;

  DatabaseService() {
    _firestore.collection('users').snapshots().listen(_usersUpdated);
    _firestore.collection('post').doc("").snapshots().listen(_postUpdated);
  }

  

  void _usersUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var users = _getUsersFromSnapshot(snapshot);
    _usersController.add(users);
  }


  void _postUpdated(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var users = _getPostFromSnapshot(snapshot);
    _postController.add(users);
  }
  Map<String, UserM> _getUsersFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (var element in snapshot.docs) {
      UserM user = UserM.fromJson(element.id, element.data());
      userMap[user.id] = user;
    }

    return userMap;
  }
}
Post _getPostFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
      Post post = Post.fromJson(snapshot.data()!);

    return post;
  }
class Post {
  final String message;
  Post({required this.message});
  Post.fromJson(Map<String,dynamic>json) : this(
    message: json["message"]
  );
}

*/