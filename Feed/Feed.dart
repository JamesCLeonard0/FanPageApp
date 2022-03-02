
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:fanpageapp/user.dart';
import 'package:fanpageapp/message.dart';
import 'package:fanpageapp/database_service.dart';
import 'package:fanpageapp/Feed/RealFeed.dart';

class Feed extends StatelessWidget {
   Feed({ Key? key , required this.displayName,required this.buttonvisible}) : super(key: key);
final _content = TextEditingController();
  @override
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference feed = FirebaseFirestore.instance.collection("feed");
  dynamic displayName;
  dynamic buttonvisible;
  final fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;
  UserM? myself;

 //DatabaseService db = DatabaseService();
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 199, 255, 126),

   appBar: AppBar(centerTitle: true,backgroundColor: Color.fromARGB(255, 0, 107, 27),title: Text("The Fantabulous Page for the Magnificent JAMES"),),
      body: Center(
     child: Column( crossAxisAlignment: CrossAxisAlignment.center ,mainAxisAlignment: MainAxisAlignment.spaceAround,children: [/*StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong querying users");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
         
/*
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                /*
              MessageModel post = 
                  MessageModel.fromJson(doc.id, doc.data() as Map<String, dynamic>);
                  */
              UserM user =
                UserM.fromJson(doc.id, doc.data() as Map<String, dynamic>);
                if(user.id == _auth.currentUser!.uid){
                    
                    myself = user;
                    
                }
          
            return ListTile(
            //  title: Text(post!.content.toString()),
              title: Text(user.displayName.toString()),
            );
          }).toList());
          */
        
        }
        ),
  */
        Form(
          child: Column(children: [  Text("Post"),
TextFormField(controller: _content,
validator: (String? value){
  onSaved: (value){
  _content.text =  value!;
  };
}), ElevatedButton(onPressed: (){
//postMessageToFirestore(_content.text, new Timestamp.now(), _auth.currentUser.uid, 'toId, id, context)

Map <String, dynamic> data = {"content":_content.text , "timestamp": DateTime.now().toString(),"from":"James Leonard" };
feed.add(data);
}, child: const Text("Send")),
ElevatedButton(onPressed: (){
//postMessageToFirestore(_content.text, new Timestamp.now(), _auth.currentUser.uid, 'toId, id, context)

Navigator.pushAndRemoveUntil((context),MaterialPageRoute(builder: (context) => RealFeed(displayName: displayName, buttonvisible: buttonvisible),), (route) => false); 


}, child: const Text("View Feed")),
],

)
        )
        ]
        ),
      
    ));
  }
 /* postMessageToFirestore(String content,Timestamp created, String fromId, String toId, String id,BuildContext context) async{
   
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
MessageModel post = MessageModel();
post.content = content;
post.created = created;
post.fromId = fromId;
post.toId = toId;
post.id = id;

await firebaseFirestore
    .collection("posts")
    .doc(post.id)
    .set(post.toJson());
 ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Post Made!")));
Navigator.pushAndRemoveUntil((context),MaterialPageRoute(builder: (context) => Feed(),), (route) => false); 


/*

UserM userModel = UserM(user?.uid,user.displayName,"USER",user?.email);
*/

 }
 */
}