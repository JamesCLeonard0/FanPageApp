
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:fanpageapp/user.dart';
import 'package:fanpageapp/message.dart';
import 'package:fanpageapp/database_service.dart';
import 'package:fanpageapp/Feed/Feed.dart';
import 'package:flutter/rendering.dart';

import 'package:fanpageapp/signup/login.dart';

class RealFeed extends StatelessWidget {
   RealFeed({ Key? key , required this.displayName,required this.buttonvisible}) : super(key: key);
//final _content = TextEditingController();
  @override
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference feed = FirebaseFirestore.instance.collection("feed");
  final fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;
  dynamic displayName;
  dynamic buttonvisible;
  

  //get admin => null;


 //DatabaseService db = DatabaseService();
  Widget build(BuildContext context) {
   // checkrole(context);
    // print(LoginPage().displayName);
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 199, 255, 126),

   appBar: AppBar(centerTitle: true,backgroundColor: Color.fromARGB(255, 0, 107, 27),title: Text("The Fantabulous Page for the Magnificent JAMES"),),
    body: StreamBuilder(stream: feed.snapshots(), 
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
       
        if(!snapshot.hasData){
              
          return const Text("No Data");
     
        }
        return ListView(
          children: snapshot.data!.docs.map((document){
          
            return Column(
              children:[
                
                Padding(padding:EdgeInsets.fromLTRB(0,100,0,0),),
              Text(document['content'],
            style: TextStyle(fontSize: 25)
            ), Text("Posted at "+(document['timestamp']),
            style: TextStyle(fontSize: 10)),
            Text("Posted by "+(document['from']),
            style: TextStyle(fontSize: 10)),
            Text("Posted for "+displayName.toString(),
            style: TextStyle(fontSize: 10)),/*
            FutureBuilder(future: checkrole(context),builder: (context, snapshot){
              if(snapshot.connectionState!= ConnectionState.done){
                return Text("");

              }
              if(_displayname != null){
              return Text(_displayname);
              }
              return Text("to you");
            },)*/
          
          ],
            );
            

          }).toList(),
        );

    }
    
    ),

    floatingActionButton :  AnimatedSlide( 
    duration: Duration(milliseconds: 300),
      offset: buttonvisible ? Offset.zero : Offset(0,2),
      child: AnimatedOpacity(
          opacity: buttonvisible ? 1 : 0,
             duration: Duration(milliseconds: 300),
      child:buttonvisible ? FloatingActionButton(


        onPressed: () {
                      Navigator.pushAndRemoveUntil((context),MaterialPageRoute(builder: (context) => Feed(displayName: displayName, buttonvisible: buttonvisible),), (route) => false); 
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add), 
      )
      : null,
      ),      
    )
   ,bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
            icon: Icon(Icons.arrow_left),
            label: 'Logout',
            
          ),
  BottomNavigationBarItem(
            icon: Icon(Icons.stop),
            label: 'Stay',
            
          ),
   ],
        selectedItemColor: Colors.amber[800],
        onTap: (index){
          if(index == 0){
            Navigator.push(context, MaterialPageRoute(builder:(context) => LoginPage()));
          }
        })
    );
  }
  
  /*
checkrole(BuildContext context) async{
    final firebaseuser = await fa.FirebaseAuth.instance.currentUser!;
  if(firebaseuser != null){
    await FirebaseFirestore.instance
    .collection('users')
    .doc(firebaseuser.uid)
    .get()
    .then((ds){
      _role = ds.get('role');
       ScaffoldMessenger.of(context).showSnackBar(  SnackBar(content: Text(_role.toString().contains('A').toString())));
       _buttonvisible = _role.toString().contains('A');
           _displayname = ds.get('display_name');
     } ).catchError((e){
        print(e);

    });
  }
  
}
*/
}

