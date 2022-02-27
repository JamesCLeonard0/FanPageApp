import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/signup/login.dart';
import 'package:fanpageapp/Feed/RealFeed.dart';
import 'package:fanpageapp/user.dart';
class signuppage extends StatelessWidget {
   signuppage({ Key? key }) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
 final _formKey = GlobalKey<FormState>();
 var _email = TextEditingController();
 var _password = TextEditingController();
  var _display = TextEditingController();
  var _passwordrep = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 199, 255, 126),

   appBar: AppBar(centerTitle: true,backgroundColor: Color.fromARGB(255, 0, 107, 27),title: Text("The Fantabulous Page for the Magnificent JAMES"),),
      
      body: Center(
      child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.center ,mainAxisAlignment: MainAxisAlignment.spaceBetween,children:  [Padding(padding:EdgeInsets.fromLTRB(0,100,0,50),),
        Text("Display Name"),
TextFormField(controller: _display,
validator: (String? value){
  onSaved: (value){
  _display.text =  value!;
  };
}),
Text("Email"),
TextFormField(controller: _email, onSaved: (value){
  _email.text =  value!;
  })
,
Text("Password"),
TextFormField(controller: _password,
obscureText: true,
validator: (String? value){
  if(value!.isEmpty){

    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Empty Password")));
    return ("Empty Password");
  }else if(value.length < 8){
    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Your password must be longer than 8 characters")));
    return ("Your password must be longer than 8 characters");
  }
  return null;
},
onSaved: (value){
  _password.text =  value!;
}
),
Text("Repeat Password"),
TextFormField(controller: _passwordrep,
obscureText: true,
validator: (String? value){
  if(value != _password.text){
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Passwords must match")));
      return ("Passwords must match");
  }
  return null;
 },
 onSaved: (value){
  _password.text =  value!;
}
),
ElevatedButton(onPressed: (){

  signUp(context, _email.text, _password.text);

}, child: const Text("Enter")),
ElevatedButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder:(context) => LoginPage()));

}, child: const Text("Login")),
//TextButton(onPressed: (){}, child: const Text("Forgot Password"))
      ],)
      
      
      
      ,)
    )
    );
  }
  //4325
void signUp(BuildContext context, String email, String password) async {

  if(_formKey.currentState!.validate()){
  
      await _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {postDetailsToFirestore(context)})
      .catchError((e){
  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Registration Unsuccessful")));
 
      });

      
  }
 // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Gross Men")));
 
}
//4250
 postDetailsToFirestore(BuildContext context) async{
   
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
User? user = _auth.currentUser;
UserM userModel = UserM();
userModel.email = user!.email!;

userModel.displayName = _display.text;
print(user.displayName);
userModel.role = "USER";
userModel.id = user.uid;

await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toJson());
 ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Account created successfully!")));
Navigator.pushAndRemoveUntil((context),MaterialPageRoute(builder: (context) => RealFeed(displayName: _display.text, buttonvisible: false)), (route) => false); 


/*

UserM userModel = UserM(user?.uid,user.displayName,"USER",user?.email);
*/

 }


  void _register(BuildContext context) async{
    try{
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(email: _email.text, password: _password.text);
       ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Registration Successful.")));
    } on FirebaseException catch(e){
      if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Email already registered."),
        ),
        );
      
      }else if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("This password is too insecure."),
        ),
        );
      }
      return;
    } 
    try{
      await _db.collection("users").doc(_auth.currentUser!.uid).set({
          "display_name" : _display.text,
          "email" : _email.text,
          "role" : "USER"
      
      });
ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Registration Successful.")));
    } on FirebaseException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Unkown Error"

      )
      )
      );
    }
  }

}



